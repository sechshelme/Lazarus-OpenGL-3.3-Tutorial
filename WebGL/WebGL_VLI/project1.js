﻿var pas = { $libimports: {}};

var rtl = {

  version: 20301,

  quiet: false,
  debug_load_units: false,
  debug_rtti: false,

  $res : {},

  debug: function(){
    if (rtl.quiet || !console || !console.log) return;
    console.log(arguments);
  },

  error: function(s){
    rtl.debug('Error: ',s);
    throw s;
  },

  warn: function(s){
    rtl.debug('Warn: ',s);
  },

  checkVersion: function(v){
    if (rtl.version != v) throw "expected rtl version "+v+", but found "+rtl.version;
  },

  hiInt: Math.pow(2,53),

  hasString: function(s){
    return rtl.isString(s) && (s.length>0);
  },

  isArray: function(a) {
    return Array.isArray(a);
  },

  isFunction: function(f){
    return typeof(f)==="function";
  },

  isModule: function(m){
    return rtl.isObject(m) && rtl.hasString(m.$name) && (pas[m.$name]===m);
  },

  isImplementation: function(m){
    return rtl.isObject(m) && rtl.isModule(m.$module) && (m.$module.$impl===m);
  },

  isNumber: function(n){
    return typeof(n)==="number";
  },

  isObject: function(o){
    var s=typeof(o);
    return (typeof(o)==="object") && (o!=null);
  },

  isString: function(s){
    return typeof(s)==="string";
  },

  getNumber: function(n){
    return typeof(n)==="number"?n:NaN;
  },

  getChar: function(c){
    return ((typeof(c)==="string") && (c.length===1)) ? c : "";
  },

  getObject: function(o){
    return ((typeof(o)==="object") || (typeof(o)==='function')) ? o : null;
  },

  isTRecord: function(type){
    return (rtl.isObject(type) && type.hasOwnProperty('$new') && (typeof(type.$new)==='function'));
  },

  isPasClass: function(type){
    return (rtl.isObject(type) && type.hasOwnProperty('$classname') && rtl.isObject(type.$module));
  },

  isPasClassInstance: function(type){
    return (rtl.isObject(type) && rtl.isPasClass(type.$class));
  },

  hexStr: function(n,digits){
    return ("000000000000000"+n.toString(16).toUpperCase()).slice(-digits);
  },

  m_loading: 0,
  m_loading_intf: 1,
  m_intf_loaded: 2,
  m_loading_impl: 3, // loading all used unit
  m_initializing: 4, // running initialization
  m_initialized: 5,

  module: function(module_name, intfuseslist, intfcode, impluseslist){
    if (rtl.debug_load_units) rtl.debug('rtl.module name="'+module_name+'" intfuses='+intfuseslist+' impluses='+impluseslist);
    if (!rtl.hasString(module_name)) rtl.error('invalid module name "'+module_name+'"');
    if (!rtl.isArray(intfuseslist)) rtl.error('invalid interface useslist of "'+module_name+'"');
    if (!rtl.isFunction(intfcode)) rtl.error('invalid interface code of "'+module_name+'"');
    if (!(impluseslist==undefined) && !rtl.isArray(impluseslist)) rtl.error('invalid implementation useslist of "'+module_name+'"');

    if (pas[module_name])
      rtl.error('module "'+module_name+'" is already registered');

    var r = Object.create(rtl.tSectionRTTI);
    var module = r.$module = pas[module_name] = {
      $name: module_name,
      $intfuseslist: intfuseslist,
      $impluseslist: impluseslist,
      $state: rtl.m_loading,
      $intfcode: intfcode,
      $implcode: null,
      $impl: null,
      $rtti: r
    };
    if (impluseslist) module.$impl = {
          $module: module,
          $rtti: r
        };
  },

  exitcode: 0,

  run: function(module_name){
    try {
      if (!rtl.hasString(module_name)) module_name='program';
      if (rtl.debug_load_units) rtl.debug('rtl.run module="'+module_name+'"');
      rtl.initRTTI();
      var module = pas[module_name];
      if (!module) rtl.error('rtl.run module "'+module_name+'" missing');
      rtl.loadintf(module);
      rtl.loadimpl(module);
      if ((module_name=='program') || (module_name=='library')){
        if (rtl.debug_load_units) rtl.debug('running $main');
        var r = pas[module_name].$main();
        if (rtl.isNumber(r)) rtl.exitcode = r;
      }
    } catch(re) {
      if (!rtl.showUncaughtExceptions) {
        throw re
      } else {  
        if (!rtl.handleUncaughtException(re)) {
          rtl.showException(re);
          rtl.exitcode = 216;
        }  
      }
    } 
    return rtl.exitcode;
  },
  
  showException : function (re) {
    var errMsg = rtl.hasString(re.$classname) ? re.$classname : '';
    errMsg +=  ((errMsg) ? ': ' : '') + (re.hasOwnProperty('fMessage') ? re.fMessage : re);
    alert('Uncaught Exception : '+errMsg);
  },

  handleUncaughtException: function (e) {
    if (rtl.onUncaughtException) {
      try {
        rtl.onUncaughtException(e);
        return true;
      } catch (ee) {
        return false; 
      }
    } else {
      return false;
    }
  },

  loadintf: function(module){
    if (module.$state>rtl.m_loading_intf) return; // already finished
    if (rtl.debug_load_units) rtl.debug('loadintf: "'+module.$name+'"');
    if (module.$state===rtl.m_loading_intf)
      rtl.error('unit cycle detected "'+module.$name+'"');
    module.$state=rtl.m_loading_intf;
    // load interfaces of interface useslist
    rtl.loaduseslist(module,module.$intfuseslist,rtl.loadintf);
    // run interface
    if (rtl.debug_load_units) rtl.debug('loadintf: run intf of "'+module.$name+'"');
    module.$intfcode(module.$intfuseslist);
    // success
    module.$state=rtl.m_intf_loaded;
    // Note: units only used in implementations are not yet loaded (not even their interfaces)
  },

  loaduseslist: function(module,useslist,f){
    if (useslist==undefined) return;
    var len = useslist.length;
    for (var i = 0; i<len; i++) {
      var unitname=useslist[i];
      if (rtl.debug_load_units) rtl.debug('loaduseslist of "'+module.$name+'" uses="'+unitname+'"');
      if (pas[unitname]==undefined)
        rtl.error('module "'+module.$name+'" misses "'+unitname+'"');
      f(pas[unitname]);
    }
  },

  loadimpl: function(module){
    if (module.$state>=rtl.m_loading_impl) return; // already processing
    if (module.$state<rtl.m_intf_loaded) rtl.error('loadimpl: interface not loaded of "'+module.$name+'"');
    if (rtl.debug_load_units) rtl.debug('loadimpl: load uses of "'+module.$name+'"');
    module.$state=rtl.m_loading_impl;
    // load interfaces of implementation useslist
    rtl.loaduseslist(module,module.$impluseslist,rtl.loadintf);
    // load implementation of interfaces useslist
    rtl.loaduseslist(module,module.$intfuseslist,rtl.loadimpl);
    // load implementation of implementation useslist
    rtl.loaduseslist(module,module.$impluseslist,rtl.loadimpl);
    // Note: At this point all interfaces used by this unit are loaded. If
    //   there are implementation uses cycles some used units might not yet be
    //   initialized. This is by design.
    // run implementation
    if (rtl.debug_load_units) rtl.debug('loadimpl: run impl of "'+module.$name+'"');
    if (rtl.isFunction(module.$implcode)) module.$implcode(module.$impluseslist);
    // run initialization
    if (rtl.debug_load_units) rtl.debug('loadimpl: run init of "'+module.$name+'"');
    module.$state=rtl.m_initializing;
    if (rtl.isFunction(module.$init)) module.$init();
    // unit initialized
    module.$state=rtl.m_initialized;
  },

  createCallback: function(scope, fn){
    var cb;
    if (typeof(fn)==='string'){
      if (!scope.hasOwnProperty('$events')) scope.$events = {};
      cb = scope.$events[fn];
      if (cb) return cb;
      scope.$events[fn] = cb = function(){
        return scope[fn].apply(scope,arguments);
      };
    } else {
      cb = function(){
        return fn.apply(scope,arguments);
      };
    };
    cb.scope = scope;
    cb.fn = fn;
    return cb;
  },

  createSafeCallback: function(scope, fn){
    var cb;
    if (typeof(fn)==='string'){
      if (!scope[fn]) return null;
      if (!scope.hasOwnProperty('$events')) scope.$events = {};
      cb = scope.$events[fn];
      if (cb) return cb;
      scope.$events[fn] = cb = function(){
        try{
          return scope[fn].apply(scope,arguments);
        } catch (err) {
          if (!rtl.handleUncaughtException(err)) throw err;
        }
      };
    } else if(!fn) {
      return null;
    } else {
      cb = function(){
        try{
          return fn.apply(scope,arguments);
        } catch (err) {
          if (!rtl.handleUncaughtException(err)) throw err;
        }
      };
    };
    cb.scope = scope;
    cb.fn = fn;
    return cb;
  },

  eqCallback: function(a,b){
    // can be a function or a function wrapper
    if (a===b){
      return true;
    } else {
      return (a!=null) && (b!=null) && (a.fn) && (a.scope===b.scope) && (a.fn===b.fn);
    }
  },

  initStruct: function(c,parent,name){
    if ((parent.$module) && (parent.$module.$impl===parent)) parent=parent.$module;
    c.$parent = parent;
    if (rtl.isModule(parent)){
      c.$module = parent;
      c.$name = name;
    } else {
      c.$module = parent.$module;
      c.$name = parent.$name+'.'+name;
    };
    return parent;
  },

  initClass: function(c,parent,name,initfn,rttiname){
    parent[name] = c;
    c.$class = c; // Note: o.$class === Object.getPrototypeOf(o)
    c.$classname = rttiname?rttiname:name;
    parent = rtl.initStruct(c,parent,name);
    c.$fullname = parent.$name+'.'+name;
    // rtti
    if (rtl.debug_rtti) rtl.debug('initClass '+c.$fullname);
    var t = c.$module.$rtti.$Class(c.$classname,{ "class": c });
    c.$rtti = t;
    if (rtl.isObject(c.$ancestor)) t.ancestor = c.$ancestor.$rtti;
    if (!t.ancestor) t.ancestor = null;
    // init members
    initfn.call(c);
  },

  createClass: function(parent,name,ancestor,initfn,rttiname){
    // create a normal class,
    // ancestor must be null or a normal class,
    // the root ancestor can be an external class
    var c = null;
    if (ancestor != null){
      c = Object.create(ancestor);
      c.$ancestor = ancestor;
      // Note:
      // if root is an "object" then c.$ancestor === Object.getPrototypeOf(c)
      // if root is a "function" then c.$ancestor === c.__proto__, Object.getPrototypeOf(c) returns the root
    } else {
      c = { $ancestor: null };
      c.$create = function(fn,args){
        if (args == undefined) args = [];
        var o = Object.create(this);
        o.$init();
        try{
          if (typeof(fn)==="string"){
            o[fn].apply(o,args);
          } else {
            fn.apply(o,args);
          };
          o.AfterConstruction();
        } catch($e){
          // do not call BeforeDestruction
          if (o.Destroy) o.Destroy();
          o.$final();
          throw $e;
        }
        return o;
      };
      c.$destroy = function(fnname){
        this.BeforeDestruction();
        if (this[fnname]) this[fnname]();
        this.$final();
      };
    };
    rtl.initClass(c,parent,name,initfn,rttiname);
  },

  createClassExt: function(parent,name,ancestor,newinstancefnname,initfn,rttiname){
    // Create a class using an external ancestor.
    // If newinstancefnname is given, use that function to create the new object.
    // If exist call BeforeDestruction and AfterConstruction.
    var isFunc = rtl.isFunction(ancestor);
    var c = null;
    if (isFunc){
      // create pascal class descendent from JS function
      c = Object.create(ancestor.prototype);
      c.$ancestorfunc = ancestor;
      c.$ancestor = null; // no pascal ancestor
    } else if (ancestor.$func){
      // create pascal class descendent from a pascal class descendent of a JS function
      isFunc = true;
      c = Object.create(ancestor);
      c.$ancestor = ancestor;
    } else {
      c = Object.create(ancestor);
      c.$ancestor = null; // no pascal ancestor
    }
    c.$create = function(fn,args){
      if (args == undefined) args = [];
      var o = null;
      if (newinstancefnname.length>0){
        o = this[newinstancefnname](fn,args);
      } else if(isFunc) {
        o = new this.$func(args);
      } else {
        o = Object.create(c);
      }
      if (o.$init) o.$init();
      try{
        if (typeof(fn)==="string"){
          this[fn].apply(o,args);
        } else {
          fn.apply(o,args);
        };
        if (o.AfterConstruction) o.AfterConstruction();
      } catch($e){
        // do not call BeforeDestruction
        if (o.Destroy) o.Destroy();
        if (o.$final) o.$final();
        throw $e;
      }
      return o;
    };
    c.$destroy = function(fnname){
      if (this.BeforeDestruction) this.BeforeDestruction();
      if (this[fnname]) this[fnname]();
      if (this.$final) this.$final();
    };
    rtl.initClass(c,parent,name,initfn,rttiname);
    if (isFunc){
      function f(){}
      f.prototype = c;
      c.$func = f;
    }
  },

  createHelper: function(parent,name,ancestor,initfn,rttiname){
    // create a helper,
    // ancestor must be null or a helper,
    var c = null;
    if (ancestor != null){
      c = Object.create(ancestor);
      c.$ancestor = ancestor;
      // c.$ancestor === Object.getPrototypeOf(c)
    } else {
      c = { $ancestor: null };
    };
    parent[name] = c;
    c.$class = c; // Note: o.$class === Object.getPrototypeOf(o)
    c.$classname = rttiname?rttiname:name;
    parent = rtl.initStruct(c,parent,name);
    c.$fullname = parent.$name+'.'+name;
    // rtti
    var t = c.$module.$rtti.$Helper(c.$classname,{ "helper": c });
    c.$rtti = t;
    if (rtl.isObject(ancestor)) t.ancestor = ancestor.$rtti;
    if (!t.ancestor) t.ancestor = null;
    // init members
    initfn.call(c);
  },

  tObjectDestroy: "Destroy",

  free: function(obj,name){
    if (obj[name]==null) return null;
    obj[name].$destroy(rtl.tObjectDestroy);
    obj[name]=null;
  },

  freeLoc: function(obj){
    if (obj==null) return null;
    obj.$destroy(rtl.tObjectDestroy);
    return null;
  },

  hideProp: function(o,p,v){
    Object.defineProperty(o,p, {
      enumerable: false,
      configurable: true,
      writable: true
    });
    if(arguments.length>2){ o[p]=v; }
  },

  recNewT: function(parent,name,initfn,full){
    // create new record type
    var t = {};
    if (parent) parent[name] = t;
    var h = rtl.hideProp;
    if (full){
      rtl.initStruct(t,parent,name);
      t.$record = t;
      h(t,'$record');
      h(t,'$name');
      h(t,'$parent');
      h(t,'$module');
      h(t,'$initSpec');
    }
    initfn.call(t);
    if (!t.$new){
      t.$new = function(){ return Object.create(t); };
    }
    t.$clone = function(r){ return t.$new().$assign(r); };
    h(t,'$new');
    h(t,'$clone');
    h(t,'$eq');
    h(t,'$assign');
    return t;
  },

  is: function(instance,type){
    return type.isPrototypeOf(instance) || (instance===type);
  },

  isExt: function(instance,type,mode){
    // mode===1 means instance must be a Pascal class instance
    // mode===2 means instance must be a Pascal class
    // Notes:
    // isPrototypeOf and instanceof return false on equal
    // isPrototypeOf does not work for Date.isPrototypeOf(new Date())
    //   so if isPrototypeOf is false test with instanceof
    // instanceof needs a function on right side
    if (instance == null) return false; // Note: ==null checks for undefined too
    if ((typeof(type) !== 'object') && (typeof(type) !== 'function')) return false;
    if (instance === type){
      if (mode===1) return false;
      if (mode===2) return rtl.isPasClass(instance);
      return true;
    }
    if (type.isPrototypeOf && type.isPrototypeOf(instance)){
      if (mode===1) return rtl.isPasClassInstance(instance);
      if (mode===2) return rtl.isPasClass(instance);
      return true;
    }
    if ((typeof type == 'function') && (instance instanceof type)) return true;
    return false;
  },

  Exception: null,
  EInvalidCast: null,
  EAbstractError: null,
  ERangeError: null,
  EIntOverflow: null,
  EPropWriteOnly: null,

  raiseE: function(typename){
    var t = rtl[typename];
    if (t==null){
      var mod = pas.SysUtils;
      if (!mod) mod = pas.sysutils;
      if (mod){
        t = mod[typename];
        if (!t) t = mod[typename.toLowerCase()];
        if (!t) t = mod['Exception'];
        if (!t) t = mod['exception'];
      }
    }
    if (t){
      if (t.Create){
        throw t.$create("Create");
      } else if (t.create){
        throw t.$create("create");
      }
    }
    if (typename === "EInvalidCast") throw "invalid type cast";
    if (typename === "EAbstractError") throw "Abstract method called";
    if (typename === "ERangeError") throw "range error";
    throw typename;
  },

  as: function(instance,type){
    if((instance === null) || rtl.is(instance,type)) return instance;
    rtl.raiseE("EInvalidCast");
  },

  asExt: function(instance,type,mode){
    if((instance === null) || rtl.isExt(instance,type,mode)) return instance;
    rtl.raiseE("EInvalidCast");
  },

  createInterface: function(module, name, guid, fnnames, ancestor, initfn, rttiname){
    //console.log('createInterface name="'+name+'" guid="'+guid+'" names='+fnnames);
    var i = ancestor?Object.create(ancestor):{};
    module[name] = i;
    i.$module = module;
    i.$name = rttiname?rttiname:name;
    i.$fullname = module.$name+'.'+i.$name;
    i.$guid = guid;
    i.$guidr = null;
    i.$names = fnnames?fnnames:[];
    if (rtl.isFunction(initfn)){
      // rtti
      if (rtl.debug_rtti) rtl.debug('createInterface '+i.$fullname);
      var t = i.$module.$rtti.$Interface(i.$name,{ "interface": i, module: module });
      i.$rtti = t;
      if (ancestor) t.ancestor = ancestor.$rtti;
      if (!t.ancestor) t.ancestor = null;
      initfn.call(i);
    }
    return i;
  },

  strToGUIDR: function(s,g){
    var p = 0;
    function n(l){
      var h = s.substr(p,l);
      p+=l;
      return parseInt(h,16);
    }
    p+=1; // skip {
    g.D1 = n(8);
    p+=1; // skip -
    g.D2 = n(4);
    p+=1; // skip -
    g.D3 = n(4);
    p+=1; // skip -
    if (!g.D4) g.D4=[];
    g.D4[0] = n(2);
    g.D4[1] = n(2);
    p+=1; // skip -
    for(var i=2; i<8; i++) g.D4[i] = n(2);
    return g;
  },

  guidrToStr: function(g){
    if (g.$intf) return g.$intf.$guid;
    var h = rtl.hexStr;
    var s='{'+h(g.D1,8)+'-'+h(g.D2,4)+'-'+h(g.D3,4)+'-'+h(g.D4[0],2)+h(g.D4[1],2)+'-';
    for (var i=2; i<8; i++) s+=h(g.D4[i],2);
    s+='}';
    return s;
  },

  createTGUID: function(guid){
    var TGuid = (pas.System)?pas.System.TGuid:pas.system.tguid;
    var g = rtl.strToGUIDR(guid,TGuid.$new());
    return g;
  },

  getIntfGUIDR: function(intfTypeOrVar){
    if (!intfTypeOrVar) return null;
    if (!intfTypeOrVar.$guidr){
      var g = rtl.createTGUID(intfTypeOrVar.$guid);
      if (!intfTypeOrVar.hasOwnProperty('$guid')) intfTypeOrVar = Object.getPrototypeOf(intfTypeOrVar);
      g.$intf = intfTypeOrVar;
      intfTypeOrVar.$guidr = g;
    }
    return intfTypeOrVar.$guidr;
  },

  addIntf: function (aclass, intf, map){
    function jmp(fn){
      if (typeof(fn)==="function"){
        return function(){ return fn.apply(this.$o,arguments); };
      } else {
        return function(){ rtl.raiseE('EAbstractError'); };
      }
    }
    if(!map) map = {};
    var t = intf;
    var item = Object.create(t);
    if (!aclass.hasOwnProperty('$intfmaps')) aclass.$intfmaps = {};
    aclass.$intfmaps[intf.$guid] = item;
    do{
      var names = t.$names;
      if (!names) break;
      for (var i=0; i<names.length; i++){
        var intfname = names[i];
        var fnname = map[intfname];
        if (!fnname) fnname = intfname;
        //console.log('addIntf: intftype='+t.$name+' index='+i+' intfname="'+intfname+'" fnname="'+fnname+'" old='+typeof(item[intfname]));
        item[intfname] = jmp(aclass[fnname]);
      }
      t = Object.getPrototypeOf(t);
    }while(t!=null);
  },

  getIntfG: function (obj, guid, query){
    if (!obj) return null;
    //console.log('getIntfG: obj='+obj.$classname+' guid='+guid+' query='+query);
    // search
    var maps = obj.$intfmaps;
    if (!maps) return null;
    var item = maps[guid];
    if (!item) return null;
    // check delegation
    //console.log('getIntfG: obj='+obj.$classname+' guid='+guid+' query='+query+' item='+typeof(item));
    if (typeof item === 'function') return item.call(obj); // delegate. Note: COM contains _AddRef
    // check cache
    var intf = null;
    if (obj.$interfaces){
      intf = obj.$interfaces[guid];
      //console.log('getIntfG: obj='+obj.$classname+' guid='+guid+' cache='+typeof(intf));
    }
    if (!intf){ // intf can be undefined!
      intf = Object.create(item);
      intf.$o = obj;
      if (!obj.$interfaces) obj.$interfaces = {};
      obj.$interfaces[guid] = intf;
    }
    if (typeof(query)==='object'){
      // called by queryIntfT
      var o = null;
      if (intf.QueryInterface(rtl.getIntfGUIDR(query),
          {get:function(){ return o; }, set:function(v){ o=v; }}) === 0){
        return o;
      } else {
        return null;
      }
    } else if(query===2){
      // called by TObject.GetInterfaceByStr
      if (intf.$kind === 'com') intf._AddRef();
    }
    return intf;
  },

  getIntfT: function(obj,intftype){
    return rtl.getIntfG(obj,intftype.$guid);
  },

  queryIntfT: function(obj,intftype){
    return rtl.getIntfG(obj,intftype.$guid,intftype);
  },

  queryIntfIsT: function(obj,intftype){
    var i = rtl.getIntfG(obj,intftype.$guid);
    if (!i) return false;
    if (i.$kind === 'com') i._Release();
    return true;
  },

  asIntfT: function (obj,intftype){
    var i = rtl.getIntfG(obj,intftype.$guid);
    if (i!==null) return i;
    rtl.raiseEInvalidCast();
  },

  intfIsIntfT: function(intf,intftype){
    return (intf!==null) && rtl.queryIntfIsT(intf.$o,intftype);
  },

  intfAsIntfT: function (intf,intftype){
    if (!intf) return null;
    var i = rtl.getIntfG(intf.$o,intftype.$guid);
    if (i) return i;
    rtl.raiseEInvalidCast();
  },

  intfIsClass: function(intf,classtype){
    return (intf!=null) && (rtl.is(intf.$o,classtype));
  },

  intfAsClass: function(intf,classtype){
    if (intf==null) return null;
    return rtl.as(intf.$o,classtype);
  },

  intfToClass: function(intf,classtype){
    if ((intf!==null) && rtl.is(intf.$o,classtype)) return intf.$o;
    return null;
  },

  // interface reference counting
  intfRefs: { // base object for temporary interface variables
    ref: function(id,intf){
      // called for temporary interface references needing delayed release
      var old = this[id];
      //console.log('rtl.intfRefs.ref: id='+id+' old="'+(old?old.$name:'null')+'" intf="'+(intf?intf.$name:'null')+' $o='+(intf?intf.$o:'null'));
      if (old){
        // called again, e.g. in a loop
        delete this[id];
        old._Release(); // may fail
      }
      if(intf) {
        this[id]=intf;
      }
      return intf;
    },
    free: function(){
      //console.log('rtl.intfRefs.free...');
      for (var id in this){
        if (this.hasOwnProperty(id)){
          var intf = this[id];
          if (intf){
            //console.log('rtl.intfRefs.free: id='+id+' '+intf.$name+' $o='+intf.$o.$classname);
            intf._Release();
          }
        }
      }
    }
  },

  createIntfRefs: function(){
    //console.log('rtl.createIntfRefs');
    return Object.create(rtl.intfRefs);
  },

  setIntfP: function(path,name,value,skipAddRef){
    var old = path[name];
    //console.log('rtl.setIntfP path='+path+' name='+name+' old="'+(old?old.$name:'null')+'" value="'+(value?value.$name:'null')+'"');
    if (old === value) return;
    if (old !== null){
      path[name]=null;
      old._Release();
    }
    if (value !== null){
      if (!skipAddRef) value._AddRef();
      path[name]=value;
    }
  },

  setIntfL: function(old,value,skipAddRef){
    //console.log('rtl.setIntfL old="'+(old?old.$name:'null')+'" value="'+(value?value.$name:'null')+'"');
    if (old !== value){
      if (value!==null){
        if (!skipAddRef) value._AddRef();
      }
      if (old!==null){
        old._Release();  // Release after AddRef, to avoid double Release if Release creates an exception
      }
    } else if (skipAddRef){
      if (old!==null){
        old._Release();  // value has an AddRef
      }
    }
    return value;
  },

  _AddRef: function(intf){
    //if (intf) console.log('rtl._AddRef intf="'+(intf?intf.$name:'null')+'"');
    if (intf) intf._AddRef();
    return intf;
  },

  _Release: function(intf){
    //if (intf) console.log('rtl._Release intf="'+(intf?intf.$name:'null')+'"');
    if (intf) intf._Release();
    return intf;
  },

  _ReleaseArray: function(a,dim){
    if (!a) return null;
    for (var i=0; i<a.length; i++){
      if (dim<=1){
        if (a[i]) a[i]._Release();
      } else {
        rtl._ReleaseArray(a[i],dim-1);
      }
    }
    return null;
  },

  trunc: function(a){
    return a<0 ? Math.ceil(a) : Math.floor(a);
  },

  checkMethodCall: function(obj,type){
    if (rtl.isObject(obj) && rtl.is(obj,type)) return;
    rtl.raiseE("EInvalidCast");
  },

  oc: function(i){
    // overflow check integer
    if ((Math.floor(i)===i) && (i>=-0x1fffffffffffff) && (i<=0x1fffffffffffff)) return i;
    rtl.raiseE('EIntOverflow');
  },

  rc: function(i,minval,maxval){
    // range check integer
    if ((Math.floor(i)===i) && (i>=minval) && (i<=maxval)) return i;
    rtl.raiseE('ERangeError');
  },

  rcc: function(c,minval,maxval){
    // range check char
    if ((typeof(c)==='string') && (c.length===1)){
      var i = c.charCodeAt(0);
      if ((i>=minval) && (i<=maxval)) return c;
    }
    rtl.raiseE('ERangeError');
  },

  rcSetCharAt: function(s,index,c){
    // range check setCharAt
    if ((typeof(s)!=='string') || (index<0) || (index>=s.length)) rtl.raiseE('ERangeError');
    return rtl.setCharAt(s,index,c);
  },

  rcCharAt: function(s,index){
    // range check charAt
    if ((typeof(s)!=='string') || (index<0) || (index>=s.length)) rtl.raiseE('ERangeError');
    return s.charAt(index);
  },

  rcArrR: function(arr,index){
    // range check read array
    if (Array.isArray(arr) && (typeof(index)==='number') && (index>=0) && (index<arr.length)){
      if (arguments.length>2){
        // arr,index1,index2,...
        arr=arr[index];
        for (var i=2; i<arguments.length; i++) arr=rtl.rcArrR(arr,arguments[i]);
        return arr;
      }
      return arr[index];
    }
    rtl.raiseE('ERangeError');
  },

  rcArrW: function(arr,index,value){
    // range check write array
    // arr,index1,index2,...,value
    for (var i=3; i<arguments.length; i++){
      arr=rtl.rcArrR(arr,index);
      index=arguments[i-1];
      value=arguments[i];
    }
    if (Array.isArray(arr) && (typeof(index)==='number') && (index>=0) && (index<arr.length)){
      return arr[index]=value;
    }
    rtl.raiseE('ERangeError');
  },

  length: function(arr){
    return (arr == null) ? 0 : arr.length;
  },

  arrayRef: function(a){
    if (a!=null) rtl.hideProp(a,'$pas2jsrefcnt',1);
    return a;
  },

  arraySetLength: function(arr,defaultvalue,newlength){
    var stack = [];
    var s = 9999;
    for (var i=2; i<arguments.length; i++){
      var j = arguments[i];
      if (j==='s'){ s = i-2; }
      else {
        stack.push({ dim:j+0, a:null, i:0, src:null });
      }
    }
    var dimmax = stack.length-1;
    var depth = 0;
    var lastlen = 0;
    var item = null;
    var a = null;
    var src = arr;
    var srclen = 0, oldlen = 0;
    do{
      if (depth>0){
        item=stack[depth-1];
        src = (item.src && item.src.length>item.i)?item.src[item.i]:null;
      }
      if (!src){
        a = [];
        srclen = 0;
        oldlen = 0;
      } else if (src.$pas2jsrefcnt>0 || depth>=s){
        a = [];
        srclen = src.length;
        oldlen = srclen;
      } else {
        a = src;
        srclen = 0;
        oldlen = a.length;
      }
      lastlen = stack[depth].dim;
      a.length = lastlen;
      if (depth>0){
        item.a[item.i]=a;
        item.i++;
        if ((lastlen===0) && (item.i<item.a.length)) continue;
      }
      if (lastlen>0){
        if (depth<dimmax){
          item = stack[depth];
          item.a = a;
          item.i = 0;
          item.src = src;
          depth++;
          continue;
        } else {
          if (srclen>lastlen) srclen=lastlen;
          if (rtl.isArray(defaultvalue)){
            // array of dyn array
            for (var i=0; i<srclen; i++) a[i]=src[i];
            for (var i=oldlen; i<lastlen; i++) a[i]=[];
          } else if (rtl.isObject(defaultvalue)) {
            if (rtl.isTRecord(defaultvalue)){
              // array of record
              for (var i=0; i<srclen; i++) a[i]=defaultvalue.$clone(src[i]);
              for (var i=oldlen; i<lastlen; i++) a[i]=defaultvalue.$new();
            } else {
              // array of set
              for (var i=0; i<srclen; i++) a[i]=rtl.refSet(src[i]);
              for (var i=oldlen; i<lastlen; i++) a[i]={};
            }
          } else {
            for (var i=0; i<srclen; i++) a[i]=src[i];
            for (var i=oldlen; i<lastlen; i++) a[i]=defaultvalue;
          }
        }
      }
      // backtrack
      while ((depth>0) && (stack[depth-1].i>=stack[depth-1].dim)){
        depth--;
      };
      if (depth===0){
        if (dimmax===0) return a;
        return stack[0].a;
      }
    }while (true);
  },

  arrayEq: function(a,b){
    if (a===null) return b===null;
    if (b===null) return false;
    if (a.length!==b.length) return false;
    for (var i=0; i<a.length; i++) if (a[i]!==b[i]) return false;
    return true;
  },

  arrayClone: function(type,src,srcpos,endpos,dst,dstpos){
    // type: 0 for references, "refset" for calling refSet(), a function for new type()
    // src must not be null
    // This function does not range check.
    if(type === 'refSet') {
      for (; srcpos<endpos; srcpos++) dst[dstpos++] = rtl.refSet(src[srcpos]); // ref set
    } else if (type === 'slice'){
      for (; srcpos<endpos; srcpos++) dst[dstpos++] = src[srcpos].slice(0); // clone static array of simple types
    } else if (typeof(type)==='function'){
      for (; srcpos<endpos; srcpos++) dst[dstpos++] = type(src[srcpos]); // clone function
    } else if (rtl.isTRecord(type)){
      for (; srcpos<endpos; srcpos++) dst[dstpos++] = type.$clone(src[srcpos]); // clone record
    }  else {
      for (; srcpos<endpos; srcpos++) dst[dstpos++] = src[srcpos]; // reference
    };
  },

  arrayConcat: function(type){
    // type: see rtl.arrayClone
    var a = [];
    var l = 0;
    for (var i=1; i<arguments.length; i++){
      var src = arguments[i];
      if (src !== null) l+=src.length;
    };
    a.length = l;
    l=0;
    for (var i=1; i<arguments.length; i++){
      var src = arguments[i];
      if (src === null) continue;
      rtl.arrayClone(type,src,0,src.length,a,l);
      l+=src.length;
    };
    return a;
  },

  arrayConcatN: function(){
    var a = null;
    for (var i=0; i<arguments.length; i++){
      var src = arguments[i];
      if (src === null) continue;
      if (a===null){
        a=rtl.arrayRef(src); // Note: concat(a) does not clone
      } else if (a['$pas2jsrefcnt']){
        a=a.concat(src); // clone a and append src
      } else {
        for (var i=0; i<src.length; i++){
          a.push(src[i]);
        }
      }
    };
    return a;
  },

  arrayPush: function(type,a){
    if(a===null){
      a=[];
    } else if (a['$pas2jsrefcnt']){
      a=rtl.arrayCopy(type,a,0,a.length);
    }
    rtl.arrayClone(type,arguments,2,arguments.length,a,a.length);
    return a;
  },

  arrayPushN: function(a){
    if(a===null){
      a=[];
    } else if (a['$pas2jsrefcnt']){
      a=a.concat();
    }
    for (var i=1; i<arguments.length; i++){
      a.push(arguments[i]);
    }
    return a;
  },

  arrayCopy: function(type, srcarray, index, count){
    // type: see rtl.arrayClone
    // if count is missing, use srcarray.length
    if (srcarray === null) return [];
    if (index < 0) index = 0;
    if (count === undefined) count=srcarray.length;
    var end = index+count;
    if (end>srcarray.length) end = srcarray.length;
    if (index>=end) return [];
    if (type===0){
      return srcarray.slice(index,end);
    } else {
      var a = [];
      a.length = end-index;
      rtl.arrayClone(type,srcarray,index,end,a,0);
      return a;
    }
  },

  arrayInsert: function(item, arr, index){
    if (arr){
      arr.splice(index,0,item);
      return arr;
    } else {
      return [item];
    }
  },

  setCharAt: function(s,index,c){
    return s.substr(0,index)+c+s.substr(index+1);
  },

  getResStr: function(mod,name){
    var rs = mod.$resourcestrings[name];
    return rs.current?rs.current:rs.org;
  },

  createSet: function(){
    var s = {};
    for (var i=0; i<arguments.length; i++){
      if (arguments[i]!=null){
        s[arguments[i]]=true;
      } else {
        var first=arguments[i+=1];
        var last=arguments[i+=1];
        for(var j=first; j<=last; j++) s[j]=true;
      }
    }
    return s;
  },

  cloneSet: function(s){
    var r = {};
    for (var key in s) r[key]=true;
    return r;
  },

  refSet: function(s){
    rtl.hideProp(s,'$shared',true);
    return s;
  },

  includeSet: function(s,enumvalue){
    if (s.$shared) s = rtl.cloneSet(s);
    s[enumvalue] = true;
    return s;
  },

  excludeSet: function(s,enumvalue){
    if (s.$shared) s = rtl.cloneSet(s);
    delete s[enumvalue];
    return s;
  },

  diffSet: function(s,t){
    var r = {};
    for (var key in s) if (!t[key]) r[key]=true;
    return r;
  },

  unionSet: function(s,t){
    var r = {};
    for (var key in s) r[key]=true;
    for (var key in t) r[key]=true;
    return r;
  },

  intersectSet: function(s,t){
    var r = {};
    for (var key in s) if (t[key]) r[key]=true;
    return r;
  },

  symDiffSet: function(s,t){
    var r = {};
    for (var key in s) if (!t[key]) r[key]=true;
    for (var key in t) if (!s[key]) r[key]=true;
    return r;
  },

  eqSet: function(s,t){
    for (var key in s) if (!t[key]) return false;
    for (var key in t) if (!s[key]) return false;
    return true;
  },

  neSet: function(s,t){
    return !rtl.eqSet(s,t);
  },

  leSet: function(s,t){
    for (var key in s) if (!t[key]) return false;
    return true;
  },

  geSet: function(s,t){
    for (var key in t) if (!s[key]) return false;
    return true;
  },

  strSetLength: function(s,newlen){
    var oldlen = s.length;
    if (oldlen > newlen){
      return s.substring(0,newlen);
    } else if (s.repeat){
      // Note: repeat needs ECMAScript6!
      return s+' '.repeat(newlen-oldlen);
    } else {
       while (oldlen<newlen){
         s+=' ';
         oldlen++;
       };
       return s;
    }
  },

  spaceLeft: function(s,width){
    var l=s.length;
    if (l>=width) return s;
    if (s.repeat){
      // Note: repeat needs ECMAScript6!
      return ' '.repeat(width-l) + s;
    } else {
      while (l<width){
        s=' '+s;
        l++;
      };
      return s;
    };
  },

  floatToStr: function(d,w,p){
    // input 1-3 arguments: double, width, precision
    if (arguments.length>2){
      return rtl.spaceLeft(d.toFixed(p),w);
    } else {
	  // exponent width
	  var pad = "";
	  var ad = Math.abs(d);
	  if (((ad>1) && (ad<1.0e+10)) ||  ((ad>1.e-10) && (ad<1))) {
		pad='00';
	  } else if ((ad>1) && (ad<1.0e+100) || (ad<1.e-10)) {
		pad='0';
      }  	
	  if (arguments.length<2) {
	    w=24;		
      } else if (w<9) {
		w=9;
      }		  
      var p = w-8;
      var s=(d>0 ? " " : "" ) + d.toExponential(p);
      s=s.replace(/e(.)/,'E$1'+pad);
      return rtl.spaceLeft(s,w);
    }
  },

  valEnum: function(s, enumType, setCodeFn){
    s = s.toLowerCase();
    for (var key in enumType){
      if((typeof(key)==='string') && (key.toLowerCase()===s)){
        setCodeFn(0);
        return enumType[key];
      }
    }
    setCodeFn(1);
    return 0;
  },

  lw: function(l){
    // fix longword bitwise operation
    return l<0?l+0x100000000:l;
  },

  and: function(a,b){
    var hi = 0x80000000;
    var low = 0x7fffffff;
    var h = (a / hi) & (b / hi);
    var l = (a & low) & (b & low);
    return h*hi + l;
  },

  or: function(a,b){
    var hi = 0x80000000;
    var low = 0x7fffffff;
    var h = (a / hi) | (b / hi);
    var l = (a & low) | (b & low);
    return h*hi + l;
  },

  xor: function(a,b){
    var hi = 0x80000000;
    var low = 0x7fffffff;
    var h = (a / hi) ^ (b / hi);
    var l = (a & low) ^ (b & low);
    return h*hi + l;
  },

  shr: function(a,b){
    if (a<0) a += rtl.hiInt;
    if (a<0x80000000) return a >> b;
    if (b<=0) return a;
    if (b>54) return 0;
    return Math.floor(a / Math.pow(2,b));
  },

  shl: function(a,b){
    if (a<0) a += rtl.hiInt;
    if (b<=0) return a;
    if (b>54) return 0;
    var r = a * Math.pow(2,b);
    if (r <= rtl.hiInt) return r;
    return r % rtl.hiInt;
  },

  initRTTI: function(){
    if (rtl.debug_rtti) rtl.debug('initRTTI');

    // base types
    rtl.tTypeInfo = { name: "tTypeInfo", kind: 0, $module: null, attr: null };
    function newBaseTI(name,kind,ancestor){
      if (!ancestor) ancestor = rtl.tTypeInfo;
      if (rtl.debug_rtti) rtl.debug('initRTTI.newBaseTI "'+name+'" '+kind+' ("'+ancestor.name+'")');
      var t = Object.create(ancestor);
      t.name = name;
      t.kind = kind;
      rtl[name] = t;
      return t;
    };
    function newBaseInt(name,minvalue,maxvalue,ordtype){
      var t = newBaseTI(name,1 /* tkInteger */,rtl.tTypeInfoInteger);
      t.minvalue = minvalue;
      t.maxvalue = maxvalue;
      t.ordtype = ordtype;
      return t;
    };
    newBaseTI("tTypeInfoInteger",1 /* tkInteger */);
    newBaseInt("shortint",-0x80,0x7f,0);
    newBaseInt("byte",0,0xff,1);
    newBaseInt("smallint",-0x8000,0x7fff,2);
    newBaseInt("word",0,0xffff,3);
    newBaseInt("longint",-0x80000000,0x7fffffff,4);
    newBaseInt("longword",0,0xffffffff,5);
    newBaseInt("nativeint",-0x10000000000000,0xfffffffffffff,6);
    newBaseInt("nativeuint",0,0xfffffffffffff,7);
    newBaseTI("char",2 /* tkChar */);
    newBaseTI("string",3 /* tkString */);
    newBaseTI("tTypeInfoEnum",4 /* tkEnumeration */,rtl.tTypeInfoInteger);
    newBaseTI("tTypeInfoSet",5 /* tkSet */);
    newBaseTI("double",6 /* tkDouble */);
    newBaseTI("boolean",7 /* tkBool */);
    newBaseTI("tTypeInfoProcVar",8 /* tkProcVar */);
    newBaseTI("tTypeInfoMethodVar",9 /* tkMethod */,rtl.tTypeInfoProcVar);
    newBaseTI("tTypeInfoArray",10 /* tkArray */);
    newBaseTI("tTypeInfoDynArray",11 /* tkDynArray */);
    newBaseTI("tTypeInfoPointer",15 /* tkPointer */);
    var t = newBaseTI("pointer",15 /* tkPointer */,rtl.tTypeInfoPointer);
    t.reftype = null;
    newBaseTI("jsvalue",16 /* tkJSValue */);
    newBaseTI("tTypeInfoRefToProcVar",17 /* tkRefToProcVar */,rtl.tTypeInfoProcVar);

    // member kinds
    rtl.tTypeMember = { attr: null };
    function newMember(name,kind){
      var m = Object.create(rtl.tTypeMember);
      m.name = name;
      m.kind = kind;
      rtl[name] = m;
    };
    newMember("tTypeMemberField",1); // tmkField
    newMember("tTypeMemberMethod",2); // tmkMethod
    newMember("tTypeMemberProperty",3); // tmkProperty

    // base object for storing members: a simple object
    rtl.tTypeMembers = {};

    // tTypeInfoStruct - base object for tTypeInfoClass, tTypeInfoRecord, tTypeInfoInterface
    var tis = newBaseTI("tTypeInfoStruct",0);
    tis.$addMember = function(name,ancestor,options){
      if (rtl.debug_rtti){
        if (!rtl.hasString(name) || (name.charAt()==='$')) throw 'invalid member "'+name+'", this="'+this.name+'"';
        if (!rtl.is(ancestor,rtl.tTypeMember)) throw 'invalid ancestor "'+ancestor+':'+ancestor.name+'", "'+this.name+'.'+name+'"';
        if ((options!=undefined) && (typeof(options)!='object')) throw 'invalid options "'+options+'", "'+this.name+'.'+name+'"';
      };
      var t = Object.create(ancestor);
      t.name = name;
      this.members[name] = t;
      this.names.push(name);
      if (rtl.isObject(options)){
        for (var key in options) if (options.hasOwnProperty(key)) t[key] = options[key];
      };
      return t;
    };
    tis.addField = function(name,type,options){
      var t = this.$addMember(name,rtl.tTypeMemberField,options);
      if (rtl.debug_rtti){
        if (!rtl.is(type,rtl.tTypeInfo)) throw 'invalid type "'+type+'", "'+this.name+'.'+name+'"';
      };
      t.typeinfo = type;
      this.fields.push(name);
      return t;
    };
    tis.addFields = function(){
      var i=0;
      while(i<arguments.length){
        var name = arguments[i++];
        var type = arguments[i++];
        if ((i<arguments.length) && (typeof(arguments[i])==='object')){
          this.addField(name,type,arguments[i++]);
        } else {
          this.addField(name,type);
        };
      };
    };
    tis.addMethod = function(name,methodkind,params,result,flags,options){
      var t = this.$addMember(name,rtl.tTypeMemberMethod,options);
      t.methodkind = methodkind;
      t.procsig = rtl.newTIProcSig(params,result,flags);
      this.methods.push(name);
      return t;
    };
    tis.addProperty = function(name,flags,result,getter,setter,options){
      var t = this.$addMember(name,rtl.tTypeMemberProperty,options);
      t.flags = flags;
      t.typeinfo = result;
      t.getter = getter;
      t.setter = setter;
      // Note: in options: params, stored, defaultvalue
      t.params = rtl.isArray(t.params) ? rtl.newTIParams(t.params) : null;
      this.properties.push(name);
      if (!rtl.isString(t.stored)) t.stored = "";
      return t;
    };
    tis.getField = function(index){
      return this.members[this.fields[index]];
    };
    tis.getMethod = function(index){
      return this.members[this.methods[index]];
    };
    tis.getProperty = function(index){
      return this.members[this.properties[index]];
    };

    newBaseTI("tTypeInfoRecord",12 /* tkRecord */,rtl.tTypeInfoStruct);
    newBaseTI("tTypeInfoClass",13 /* tkClass */,rtl.tTypeInfoStruct);
    newBaseTI("tTypeInfoClassRef",14 /* tkClassRef */);
    newBaseTI("tTypeInfoInterface",18 /* tkInterface */,rtl.tTypeInfoStruct);
    newBaseTI("tTypeInfoHelper",19 /* tkHelper */,rtl.tTypeInfoStruct);
    newBaseTI("tTypeInfoExtClass",20 /* tkExtClass */,rtl.tTypeInfoClass);
  },

  tSectionRTTI: {
    $module: null,
    $inherited: function(name,ancestor,o){
      if (rtl.debug_rtti){
        rtl.debug('tSectionRTTI.newTI "'+(this.$module?this.$module.$name:"(no module)")
          +'"."'+name+'" ('+ancestor.name+') '+(o?'init':'forward'));
      };
      var t = this[name];
      if (t){
        if (!t.$forward) throw 'duplicate type "'+name+'"';
        if (!ancestor.isPrototypeOf(t)) throw 'typeinfo ancestor mismatch "'+name+'" ancestor="'+ancestor.name+'" t.name="'+t.name+'"';
      } else {
        t = Object.create(ancestor);
        t.name = name;
        t.$module = this.$module;
        this[name] = t;
      }
      if (o){
        delete t.$forward;
        for (var key in o) if (o.hasOwnProperty(key)) t[key]=o[key];
      } else {
        t.$forward = true;
      }
      return t;
    },
    $Scope: function(name,ancestor,o){
      var t=this.$inherited(name,ancestor,o);
      t.members = {};
      t.names = [];
      t.fields = [];
      t.methods = [];
      t.properties = [];
      return t;
    },
    $TI: function(name,kind,o){ var t=this.$inherited(name,rtl.tTypeInfo,o); t.kind = kind; return t; },
    $Int: function(name,o){ return this.$inherited(name,rtl.tTypeInfoInteger,o); },
    $Enum: function(name,o){ return this.$inherited(name,rtl.tTypeInfoEnum,o); },
    $Set: function(name,o){ return this.$inherited(name,rtl.tTypeInfoSet,o); },
    $StaticArray: function(name,o){ return this.$inherited(name,rtl.tTypeInfoArray,o); },
    $DynArray: function(name,o){ return this.$inherited(name,rtl.tTypeInfoDynArray,o); },
    $ProcVar: function(name,o){ return this.$inherited(name,rtl.tTypeInfoProcVar,o); },
    $RefToProcVar: function(name,o){ return this.$inherited(name,rtl.tTypeInfoRefToProcVar,o); },
    $MethodVar: function(name,o){ return this.$inherited(name,rtl.tTypeInfoMethodVar,o); },
    $Record: function(name,o){ return this.$Scope(name,rtl.tTypeInfoRecord,o); },
    $Class: function(name,o){ return this.$Scope(name,rtl.tTypeInfoClass,o); },
    $ClassRef: function(name,o){ return this.$inherited(name,rtl.tTypeInfoClassRef,o); },
    $Pointer: function(name,o){ return this.$inherited(name,rtl.tTypeInfoPointer,o); },
    $Interface: function(name,o){ return this.$Scope(name,rtl.tTypeInfoInterface,o); },
    $Helper: function(name,o){ return this.$Scope(name,rtl.tTypeInfoHelper,o); },
    $ExtClass: function(name,o){ return this.$Scope(name,rtl.tTypeInfoExtClass,o); }
  },

  newTIParam: function(param){
    // param is an array, 0=name, 1=type, 2=optional flags
    var t = {
      name: param[0],
      typeinfo: param[1],
      flags: (rtl.isNumber(param[2]) ? param[2] : 0)
    };
    return t;
  },

  newTIParams: function(list){
    // list: optional array of [paramname,typeinfo,optional flags]
    var params = [];
    if (rtl.isArray(list)){
      for (var i=0; i<list.length; i++) params.push(rtl.newTIParam(list[i]));
    };
    return params;
  },

  newTIProcSig: function(params,result,flags){
    var s = {
      params: rtl.newTIParams(params),
      resulttype: result?result:null,
      flags: flags?flags:0
    };
    return s;
  },

  addResource: function(aRes){
    rtl.$res[aRes.name]=aRes;
  },

  getResource: function(aName){
    var res = rtl.$res[aName];
    if (res !== undefined) {
      return res;
    } else {
      return null;
    }
  },

  getResourceList: function(){
    return Object.keys(rtl.$res);
  }
}

rtl.module("System",[],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  rtl.createClass(this,"TObject",null,function () {
    this.$init = function () {
    };
    this.$final = function () {
    };
    this.Create = function () {
      return this;
    };
    this.Destroy = function () {
    };
    this.AfterConstruction = function () {
    };
    this.BeforeDestruction = function () {
    };
  });
  this.IsConsole = false;
  this.OnParamCount = null;
  this.OnParamStr = null;
  this.Copy = function (S, Index, Size) {
    if (Index<1) Index = 1;
    return (Size>0) ? S.substring(Index-1,Index+Size-1) : "";
  };
  this.Copy$1 = function (S, Index) {
    if (Index<1) Index = 1;
    return S.substr(Index-1);
  };
  this.Writeln = function () {
    var i = 0;
    var l = 0;
    var s = "";
    l = arguments.length - 1;
    if ($impl.WriteCallBack != null) {
      for (var $l = 0, $end = l; $l <= $end; $l++) {
        i = $l;
        $impl.WriteCallBack(arguments[i],i === l);
      };
    } else {
      s = $impl.WriteBuf;
      for (var $l1 = 0, $end1 = l; $l1 <= $end1; $l1++) {
        i = $l1;
        s = s + ("" + arguments[i]);
      };
      console.log(s);
      $impl.WriteBuf = "";
    };
  };
  this.SetWriteCallBack = function (H) {
    var Result = null;
    Result = $impl.WriteCallBack;
    $impl.WriteCallBack = H;
    return Result;
  };
  $mod.$implcode = function () {
    $impl.WriteBuf = "";
    $impl.WriteCallBack = null;
  };
  $mod.$init = function () {
    rtl.exitcode = 0;
  };
},[]);
rtl.module("Types",["System"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("JS",["System","Types"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass(this,"EJS",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.FMessage = "";
    };
    this.Create$1 = function (Msg) {
      this.FMessage = Msg;
      return this;
    };
  });
  this.New = function (aElements) {
    var Result = null;
    var L = 0;
    var I = 0;
    var S = "";
    L = rtl.length(aElements);
    if ((L % 2) === 1) throw $mod.EJS.$create("Create$1",["Number of arguments must be even"]);
    I = 0;
    while (I < L) {
      if (!rtl.isString(aElements[I])) {
        S = String(I);
        throw $mod.EJS.$create("Create$1",["Argument " + S + " must be a string."]);
      };
      I += 2;
    };
    I = 0;
    Result = new Object();
    while (I < L) {
      S = "" + aElements[I];
      Result[S] = aElements[I + 1];
      I += 2;
    };
    return Result;
  };
});
rtl.module("weborworker",["System","JS","Types"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("Web",["System","Types","JS","weborworker"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("SysUtils",["System","JS"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  this.FreeAndNil = function (Obj) {
    var o = null;
    o = Obj.get();
    if (o === null) return;
    Obj.set(null);
    o.$destroy("Destroy");
  };
  this.LowerCase = function (s) {
    return s.toLowerCase();
  };
  this.TStringReplaceFlag = {"0": "rfReplaceAll", rfReplaceAll: 0, "1": "rfIgnoreCase", rfIgnoreCase: 1};
  this.StringReplace = function (aOriginal, aSearch, aReplace, Flags) {
    var Result = "";
    var REFlags = "";
    var REString = "";
    REFlags = "";
    if (0 in Flags) REFlags = "g";
    if (1 in Flags) REFlags = REFlags + "i";
    REString = aSearch.replace(new RegExp($impl.RESpecials,"g"),"\\$1");
    Result = aOriginal.replace(new RegExp(REString,REFlags),aReplace);
    return Result;
  };
  this.OnGetEnvironmentVariable = null;
  this.OnGetEnvironmentString = null;
  this.OnGetEnvironmentVariableCount = null;
  this.ShortMonthNames = rtl.arraySetLength(null,"",12);
  this.LongMonthNames = rtl.arraySetLength(null,"",12);
  this.ShortDayNames = rtl.arraySetLength(null,"",7);
  this.LongDayNames = rtl.arraySetLength(null,"",7);
  this.TStringSplitOptions = {"0": "None", None: 0, "1": "ExcludeEmpty", ExcludeEmpty: 1};
  rtl.createHelper(this,"TStringHelper",null,function () {
    this.GetLength = function () {
      var Result = 0;
      Result = this.get().length;
      return Result;
    };
    this.IndexOfAny$3 = function (AnyOf, StartIndex) {
      var Result = 0;
      Result = $mod.TStringHelper.IndexOfAny$5.call(this,AnyOf,StartIndex,$mod.TStringHelper.GetLength.call(this));
      return Result;
    };
    this.IndexOfAny$5 = function (AnyOf, StartIndex, ACount) {
      var Result = 0;
      var i = 0;
      var L = 0;
      i = StartIndex + 1;
      L = (i + ACount) - 1;
      if (L > $mod.TStringHelper.GetLength.call(this)) L = $mod.TStringHelper.GetLength.call(this);
      Result = -1;
      while ((Result === -1) && (i <= L)) {
        if ($impl.HaveChar(this.get().charAt(i - 1),AnyOf)) Result = i - 1;
        i += 1;
      };
      return Result;
    };
    this.IndexOfAnyUnquoted$1 = function (AnyOf, StartQuote, EndQuote, StartIndex) {
      var Result = 0;
      Result = $mod.TStringHelper.IndexOfAnyUnquoted$2.call(this,AnyOf,StartQuote,EndQuote,StartIndex,$mod.TStringHelper.GetLength.call(this));
      return Result;
    };
    this.IndexOfAnyUnquoted$2 = function (AnyOf, StartQuote, EndQuote, StartIndex, ACount) {
      var Result = 0;
      var I = 0;
      var L = 0;
      var Q = 0;
      Result = -1;
      L = (StartIndex + ACount) - 1;
      if (L > $mod.TStringHelper.GetLength.call(this)) L = $mod.TStringHelper.GetLength.call(this);
      I = StartIndex + 1;
      Q = 0;
      if (StartQuote === EndQuote) {
        while ((Result === -1) && (I <= L)) {
          if (this.get().charAt(I - 1) === StartQuote) Q = 1 - Q;
          if ((Q === 0) && $impl.HaveChar(this.get().charAt(I - 1),AnyOf)) Result = I - 1;
          I += 1;
        };
      } else {
        while ((Result === -1) && (I <= L)) {
          if (this.get().charAt(I - 1) === StartQuote) {
            Q += 1}
           else if ((this.get().charAt(I - 1) === EndQuote) && (Q > 0)) Q -= 1;
          if ((Q === 0) && $impl.HaveChar(this.get().charAt(I - 1),AnyOf)) Result = I - 1;
          I += 1;
        };
      };
      return Result;
    };
    this.Split$1 = function (Separators) {
      var Result = [];
      Result = $mod.TStringHelper.Split$21.call(this,Separators,"\x00","\x00",$mod.TStringHelper.GetLength.call(this) + 1,0);
      return Result;
    };
    var BlockSize = 10;
    this.Split$21 = function (Separators, AQuoteStart, AQuoteEnd, ACount, Options) {
      var $Self = this;
      var Result = [];
      var S = "";
      function NextSep(StartIndex) {
        var Result = 0;
        if (AQuoteStart !== "\x00") {
          Result = $mod.TStringHelper.IndexOfAnyUnquoted$1.call({get: function () {
              return S;
            }, set: function (v) {
              S = v;
            }},Separators,AQuoteStart,AQuoteEnd,StartIndex)}
         else Result = $mod.TStringHelper.IndexOfAny$3.call({get: function () {
            return S;
          }, set: function (v) {
            S = v;
          }},Separators,StartIndex);
        return Result;
      };
      function MaybeGrow(Curlen) {
        if (rtl.length(Result) <= Curlen) Result = rtl.arraySetLength(Result,"",rtl.length(Result) + 10);
      };
      var Sep = 0;
      var LastSep = 0;
      var Len = 0;
      var T = "";
      S = $Self.get();
      Result = rtl.arraySetLength(Result,"",10);
      Len = 0;
      LastSep = 0;
      Sep = NextSep(0);
      while ((Sep !== -1) && ((ACount === 0) || (Len < ACount))) {
        T = $mod.TStringHelper.Substring$1.call($Self,LastSep,Sep - LastSep);
        if ((T !== "") || !(1 === Options)) {
          MaybeGrow(Len);
          Result[Len] = T;
          Len += 1;
        };
        LastSep = Sep + 1;
        Sep = NextSep(LastSep);
      };
      if ((LastSep <= $mod.TStringHelper.GetLength.call($Self)) && ((ACount === 0) || (Len < ACount))) {
        T = $mod.TStringHelper.Substring.call($Self,LastSep);
        if ((T !== "") || !(1 === Options)) {
          MaybeGrow(Len);
          Result[Len] = T;
          Len += 1;
        };
      };
      Result = rtl.arraySetLength(Result,"",Len);
      return Result;
    };
    this.Substring = function (AStartIndex) {
      var Result = "";
      Result = $mod.TStringHelper.Substring$1.call(this,AStartIndex,$mod.TStringHelper.GetLength.call(this) - AStartIndex);
      return Result;
    };
    this.Substring$1 = function (AStartIndex, ALen) {
      var Result = "";
      Result = pas.System.Copy(this.get(),AStartIndex + 1,ALen);
      return Result;
    };
  });
  $mod.$implcode = function () {
    $impl.DefaultShortMonthNames = ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
    $impl.DefaultLongMonthNames = ["January","February","March","April","May","June","July","August","September","October","November","December"];
    $impl.DefaultShortDayNames = ["Sun","Mon","Tue","Wed","Thu","Fri","Sat"];
    $impl.DefaultLongDayNames = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    $impl.RESpecials = "([\\$\\+\\[\\]\\(\\)\\\\\\.\\*\\^\\?\\|])";
    $impl.HaveChar = function (AChar, AList) {
      var Result = false;
      var I = 0;
      I = 0;
      Result = false;
      while (!Result && (I < rtl.length(AList))) {
        Result = AList[I] === AChar;
        I += 1;
      };
      return Result;
    };
  };
  $mod.$init = function () {
    $mod.ShortMonthNames = $impl.DefaultShortMonthNames.slice(0);
    $mod.LongMonthNames = $impl.DefaultLongMonthNames.slice(0);
    $mod.ShortDayNames = $impl.DefaultShortDayNames.slice(0);
    $mod.LongDayNames = $impl.DefaultLongDayNames.slice(0);
  };
},[]);
rtl.module("Classes",["System","Types","SysUtils","JS"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  rtl.createClass(this,"TLoadHelper",pas.System.TObject,function () {
  });
  this.SetLoadHelperClass = function (aClass) {
    var Result = null;
    Result = $impl.GlobalLoadHelper;
    $impl.GlobalLoadHelper = aClass;
    return Result;
  };
  $mod.$implcode = function () {
    $impl.GlobalLoadHelper = null;
    $impl.ClassList = null;
  };
  $mod.$init = function () {
    $impl.ClassList = new Object();
  };
},[]);
rtl.module("Rtl.BrowserLoadHelper",["System","Classes","SysUtils","JS","Web"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass(this,"TBrowserLoadHelper",pas.Classes.TLoadHelper,function () {
  });
  $mod.$init = function () {
    pas.Classes.SetLoadHelperClass($mod.TBrowserLoadHelper);
  };
});
rtl.module("browserconsole",["System","JS","Web","Rtl.BrowserLoadHelper","SysUtils"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  this.BrowserLineBreak = "\n";
  this.DefaultMaxConsoleLines = 25;
  this.DefaultConsoleStyle = ".pasconsole { " + this.BrowserLineBreak + "font-family: courier;" + this.BrowserLineBreak + "font-size: 14px;" + this.BrowserLineBreak + "background: #FFFFFF;" + this.BrowserLineBreak + "color: #000000;" + this.BrowserLineBreak + "display: block;" + this.BrowserLineBreak + "}";
  this.ConsoleElementID = "";
  this.ConsoleStyle = "";
  this.MaxConsoleLines = 0;
  this.ConsoleLinesToBrowserLog = false;
  this.ResetConsole = function () {
    if ($impl.LinesParent === null) return;
    while ($impl.LinesParent.firstElementChild !== null) $impl.LinesParent.removeChild($impl.LinesParent.firstElementChild);
    $impl.AppendLine();
  };
  this.InitConsole = function () {
    if ($impl.ConsoleElement === null) return;
    if ($impl.ConsoleElement.nodeName.toLowerCase() !== "body") {
      while ($impl.ConsoleElement.firstElementChild !== null) $impl.ConsoleElement.removeChild($impl.ConsoleElement.firstElementChild);
    };
    $impl.StyleElement = document.createElement("style");
    $impl.StyleElement.innerText = $mod.ConsoleStyle;
    $impl.ConsoleElement.appendChild($impl.StyleElement);
    $impl.LinesParent = document.createElement("div");
    $impl.ConsoleElement.appendChild($impl.LinesParent);
  };
  this.HookConsole = function () {
    $impl.ConsoleElement = null;
    if ($mod.ConsoleElementID !== "") $impl.ConsoleElement = document.getElementById($mod.ConsoleElementID);
    if ($impl.ConsoleElement === null) $impl.ConsoleElement = document.body;
    if ($impl.ConsoleElement === null) return;
    $mod.InitConsole();
    $mod.ResetConsole();
    pas.System.SetWriteCallBack($impl.WriteConsole);
  };
  $mod.$implcode = function () {
    $impl.LastLine = null;
    $impl.StyleElement = null;
    $impl.LinesParent = null;
    $impl.ConsoleElement = null;
    $impl.AppendLine = function () {
      var CurrentCount = 0;
      var S = null;
      CurrentCount = 0;
      S = $impl.LinesParent.firstChild;
      while (S != null) {
        CurrentCount += 1;
        S = S.nextSibling;
      };
      while (CurrentCount > $mod.MaxConsoleLines) {
        CurrentCount -= 1;
        $impl.LinesParent.removeChild($impl.LinesParent.firstChild);
      };
      $impl.LastLine = document.createElement("div");
      $impl.LastLine.className = "pasconsole";
      $impl.LinesParent.appendChild($impl.LastLine);
    };
    $impl.EscapeString = function (S) {
      var Result = "";
      var CL = "";
      CL = pas.SysUtils.StringReplace(S,"<","&lt;",rtl.createSet(0));
      CL = pas.SysUtils.StringReplace(CL,">","&gt;",rtl.createSet(0));
      CL = pas.SysUtils.StringReplace(CL," ","&nbsp;",rtl.createSet(0));
      CL = pas.SysUtils.StringReplace(CL,"\r\n","<br>",rtl.createSet(0));
      CL = pas.SysUtils.StringReplace(CL,"\n","<br>",rtl.createSet(0));
      CL = pas.SysUtils.StringReplace(CL,"\r","<br>",rtl.createSet(0));
      Result = CL;
      return Result;
    };
    $impl.WriteConsole = function (S, NewLine) {
      var CL = "";
      CL = $impl.LastLine.innerHTML;
      CL = CL + $impl.EscapeString("" + S);
      $impl.LastLine.innerHTML = CL;
      if (NewLine) {
        if ($mod.ConsoleLinesToBrowserLog) window.console.log($impl.LastLine.innerText);
        $impl.AppendLine();
      };
    };
  };
  $mod.$init = function () {
    $mod.ConsoleLinesToBrowserLog = true;
    $mod.ConsoleElementID = "pasjsconsole";
    $mod.ConsoleStyle = $mod.DefaultConsoleStyle;
    $mod.MaxConsoleLines = 25;
    $mod.HookConsole();
  };
},[]);
rtl.module("BrowserApp",["System","Classes","SysUtils","Types","JS","Web"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  this.ReloadEnvironmentStrings = function () {
    var I = 0;
    var S = "";
    var N = "";
    var A = [];
    var P = [];
    if ($impl.EnvNames != null) pas.SysUtils.FreeAndNil({p: $impl, get: function () {
        return this.p.EnvNames;
      }, set: function (v) {
        this.p.EnvNames = v;
      }});
    $impl.EnvNames = new Object();
    S = window.location.search;
    S = pas.System.Copy(S,2,S.length - 1);
    A = S.split("&");
    for (var $l = 0, $end = rtl.length(A) - 1; $l <= $end; $l++) {
      I = $l;
      P = A[I].split("=");
      N = pas.SysUtils.LowerCase(decodeURIComponent(P[0]));
      if (rtl.length(P) === 2) {
        $impl.EnvNames[N] = decodeURIComponent(P[1])}
       else if (rtl.length(P) === 1) $impl.EnvNames[N] = "";
    };
  };
  $mod.$implcode = function () {
    $impl.EnvNames = null;
    $impl.Params = [];
    $impl.ReloadParamStrings = function () {
      var ParsLine = "";
      var Pars = [];
      var I = 0;
      ParsLine = pas.System.Copy$1(window.location.hash,2);
      if (ParsLine !== "") {
        Pars = pas.SysUtils.TStringHelper.Split$1.call({get: function () {
            return ParsLine;
          }, set: function (v) {
            ParsLine = v;
          }},["/"])}
       else Pars = rtl.arraySetLength(Pars,"",0);
      $impl.Params = rtl.arraySetLength($impl.Params,"",1 + rtl.length(Pars));
      $impl.Params[0] = window.location.pathname;
      for (var $l = 0, $end = rtl.length(Pars) - 1; $l <= $end; $l++) {
        I = $l;
        $impl.Params[1 + I] = Pars[I];
      };
    };
    $impl.GetParamCount = function () {
      var Result = 0;
      Result = rtl.length($impl.Params) - 1;
      return Result;
    };
    $impl.GetParamStr = function (Index) {
      var Result = "";
      if ((Index >= 0) && (Index < rtl.length($impl.Params))) Result = $impl.Params[Index];
      return Result;
    };
    $impl.MyGetEnvironmentVariable = function (EnvVar) {
      var Result = "";
      var aName = "";
      aName = pas.SysUtils.LowerCase(EnvVar);
      if ($impl.EnvNames.hasOwnProperty(aName)) {
        Result = "" + $impl.EnvNames[aName]}
       else Result = "";
      return Result;
    };
    $impl.MyGetEnvironmentVariableCount = function () {
      var Result = 0;
      Result = rtl.length(Object.getOwnPropertyNames($impl.EnvNames));
      return Result;
    };
    $impl.MyGetEnvironmentString = function (Index) {
      var Result = "";
      Result = "" + $impl.EnvNames[Object.getOwnPropertyNames($impl.EnvNames)[Index]];
      return Result;
    };
  };
  $mod.$init = function () {
    pas.System.IsConsole = true;
    pas.System.OnParamCount = $impl.GetParamCount;
    pas.System.OnParamStr = $impl.GetParamStr;
    $mod.ReloadEnvironmentStrings();
    $impl.ReloadParamStrings();
    pas.SysUtils.OnGetEnvironmentVariable = $impl.MyGetEnvironmentVariable;
    pas.SysUtils.OnGetEnvironmentVariableCount = $impl.MyGetEnvironmentVariableCount;
    pas.SysUtils.OnGetEnvironmentString = $impl.MyGetEnvironmentString;
  };
},[]);
rtl.module("webgl",["System","JS","Web"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("wglCommon",["System","webgl"],function () {
  "use strict";
  var $mod = this;
  this.gl = null;
});
rtl.module("wglMatrix",["System","Types","SysUtils","browserconsole","webgl","JS","wglCommon"],function () {
  "use strict";
  var $mod = this;
  this.isGold = false;
  this.Geschnitten = true;
  this.TMatrix$clone = function (a) {
    var b = [];
    b.length = 4;
    for (var c = 0; c < 4; c++) b[c] = a[c].slice(0);
    return b;
  };
  rtl.createHelper(this,"TMatrixfHelper",null,function () {
    this.Identity = function () {
      this.set([[1.0,0.0,0.0,0.0],[0.0,1.0,0.0,0.0],[0.0,0.0,1.0,0.0],[0.0,0.0,0.0,1.0]]);
    };
    this.Frustum = function (left, right, bottom, top, near, far) {
      var rl = 0.0;
      var tb = 0.0;
      var fn = 0.0;
      rl = right - left;
      tb = top - bottom;
      fn = far - near;
      this.get()[0][0] = (2 * near) / rl;
      this.get()[0][1] = 0.0;
      this.get()[0][2] = 0.0;
      this.get()[0][3] = 0.0;
      this.get()[1][0] = 0.0;
      this.get()[1][1] = (2 * near) / tb;
      this.get()[1][2] = 0.0;
      this.get()[1][3] = 0.0;
      this.get()[2][0] = (right + left) / rl;
      this.get()[2][1] = (top + bottom) / tb;
      this.get()[2][2] = -(far + near) / fn;
      this.get()[2][3] = -1.0;
      this.get()[3][0] = 0.0;
      this.get()[3][1] = 0.0;
      this.get()[3][2] = (-2 * far * near) / fn;
      this.get()[3][3] = 0.0;
    };
    this.Perspective = function (fovy, aspect, znear, zfar) {
      var p = 0.0;
      var right = 0.0;
      var top = 0.0;
      p = (fovy * Math.PI) / 360;
      top = znear * (Math.sin(p) / Math.cos(p));
      right = top * aspect;
      $mod.TMatrixfHelper.Frustum.call(this,-right,right,-top,top,znear,zfar);
    };
    this.Scale = function (Faktor) {
      var i = 0;
      for (i = 0; i <= 2; i++) {
        this.get()[i][0] *= Faktor[i];
        this.get()[i][1] *= Faktor[i];
        this.get()[i][2] *= Faktor[i];
        this.get()[i][3] *= Faktor[i];
      };
    };
    this.Scale$1 = function (Faktor) {
      var i = 0;
      for (i = 0; i <= 2; i++) {
        this.get()[i][0] *= Faktor;
        this.get()[i][1] *= Faktor;
        this.get()[i][2] *= Faktor;
        this.get()[i][3] *= Faktor;
      };
    };
    this.RotateA = function (angele) {
      var i = 0;
      var y = 0.0;
      var z = 0.0;
      var c = 0.0;
      var s = 0.0;
      c = Math.cos(angele);
      s = Math.sin(angele);
      for (i = 0; i <= 2; i++) {
        y = this.get()[i][1];
        z = this.get()[i][2];
        this.get()[i][1] = (y * c) - (z * s);
        this.get()[i][2] = (y * s) + (z * c);
      };
    };
    this.RotateB = function (angele) {
      var i = 0;
      var x = 0.0;
      var z = 0.0;
      var c = 0.0;
      var s = 0.0;
      c = Math.cos(angele);
      s = Math.sin(angele);
      for (i = 0; i <= 2; i++) {
        x = this.get()[i][0];
        z = this.get()[i][2];
        this.get()[i][0] = (x * c) - (z * s);
        this.get()[i][2] = (x * s) + (z * c);
      };
    };
    this.RotateC = function (angele) {
      var i = 0;
      var x = 0.0;
      var y = 0.0;
      var c = 0.0;
      var s = 0.0;
      c = Math.cos(angele);
      s = Math.sin(angele);
      for (i = 0; i <= 2; i++) {
        x = this.get()[i][0];
        y = this.get()[i][1];
        this.get()[i][0] = (x * c) - (y * s);
        this.get()[i][1] = (x * s) + (y * c);
      };
    };
    this.Translate = function (v) {
      this.get()[3][0] += v[0];
      this.get()[3][1] += v[1];
      this.get()[3][2] += v[2];
    };
    this.Translate$1 = function (x, y, z) {
      this.get()[3][0] += x;
      this.get()[3][1] += y;
      this.get()[3][2] += z;
    };
    this.TranslateLocalspace = function (x, y, z) {
      var i = 0;
      for (i = 0; i <= 3; i++) {
        this.get()[3][i] += (this.get()[0][i] * x) + (this.get()[1][i] * y) + (this.get()[2][i] * z);
      };
    };
    this.GetFloatList = function () {
      var Result = rtl.arraySetLength(null,0.0,16);
      var x = 0;
      var y = 0;
      for (x = 0; x <= 3; x++) {
        for (y = 0; y <= 3; y++) {
          Result[(x * 4) + y] = this.get()[x][y];
        };
      };
      return Result;
    };
    this.Uniform = function (ShaderID) {
      pas.wglCommon.gl.uniformMatrix4fv(ShaderID,false,$mod.TMatrixfHelper.GetFloatList.call(this));
    };
  });
  this.vec4 = function (xyz, w) {
    var Result = rtl.arraySetLength(null,0.0,4);
    Result[0] = xyz[0];
    Result[1] = xyz[1];
    Result[2] = xyz[2];
    Result[3] = w;
    return Result;
  };
  this.MatrixMultiple = function (mat0, mat1) {
    var Result = rtl.arraySetLength(null,0.0,4,4);
    var i = 0;
    var j = 0;
    var k = 0;
    for (i = 0; i <= 3; i++) {
      for (j = 0; j <= 3; j++) {
        Result[i][j] = 0.0;
        for (k = 0; k <= 3; k++) {
          Result[i][j] += mat1[i][k] * mat0[k][j];
        };
      };
    };
    return Result;
  };
  this.WorldMatrix = rtl.arraySetLength(null,0.0,4,4);
  this.ObjectMatrix = rtl.arraySetLength(null,0.0,4,4);
  this.GlobusMatrix = rtl.arraySetLength(null,0.0,4,4);
  this.CloudsMatrix = rtl.arraySetLength(null,0.0,4,4);
  this.mProjectionMatrix = rtl.arraySetLength(null,0.0,4,4);
  this.mRotationMatrix = rtl.arraySetLength(null,0.0,4,4);
  this.vec3green = [0.0,1.0,0.0];
  this.vec3red = [1.0,0.0,0.0];
  this.vec3yellow = [1.0,1.0,0.0];
  this.vec3white = [1.0,1.0,1.0];
  $mod.$init = function () {
    $mod.TMatrixfHelper.Identity.call({p: $mod, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }});
    $mod.TMatrixfHelper.Identity.call({p: $mod, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }});
    $mod.TMatrixfHelper.Identity.call({p: $mod, get: function () {
        return this.p.GlobusMatrix;
      }, set: function (v) {
        this.p.GlobusMatrix = v;
      }});
    $mod.TMatrixfHelper.Identity.call({p: $mod, get: function () {
        return this.p.CloudsMatrix;
      }, set: function (v) {
        this.p.CloudsMatrix = v;
      }});
    $mod.TMatrixfHelper.Identity.call({p: $mod, get: function () {
        return this.p.mProjectionMatrix;
      }, set: function (v) {
        this.p.mProjectionMatrix = v;
      }});
    $mod.TMatrixfHelper.Identity.call({p: $mod, get: function () {
        return this.p.mRotationMatrix;
      }, set: function (v) {
        this.p.mRotationMatrix = v;
      }});
  };
});
rtl.module("wglShader",["System","Types","SysUtils","browserconsole","webgl","JS","wglCommon","wglMatrix"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass(this,"TShader",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.FProgramObject = null;
    };
    this.$final = function () {
      this.FProgramObject = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.GetShader = function (e) {
      var Result = "";
      var $tmp = e;
      if ($tmp === 35633) {
        Result = "VERTEX_SHADER";
      } else if ($tmp === 35632) {
        Result = "gFRAGMENT_SHADER";
      };
      return Result;
    };
    this.Create$1 = function () {
      this.FProgramObject = pas.wglCommon.gl.createProgram();
      return this;
    };
    this.Destroy = function () {
      pas.wglCommon.gl.deleteProgram(this.FProgramObject);
      pas.System.TObject.Destroy.call(this);
    };
    this.LoadShaderObject = function (shaderType, AShader) {
      var ShaderObject = null;
      ShaderObject = pas.wglCommon.gl.createShader(shaderType);
      if (ShaderObject === null) {
        pas.System.Writeln("create shader failed");
      };
      pas.wglCommon.gl.shaderSource(ShaderObject,AShader);
      pas.wglCommon.gl.compileShader(ShaderObject);
      if (!pas.wglCommon.gl.getShaderParameter(ShaderObject,35713)) {
        pas.System.Writeln("Fehler in ",this.GetShader(shaderType),": ",pas.wglCommon.gl.getShaderInfoLog(ShaderObject));
      };
      pas.wglCommon.gl.attachShader(this.FProgramObject,ShaderObject);
    };
    this.LinkProgram = function () {
      pas.wglCommon.gl.linkProgram(this.FProgramObject);
      if (!pas.wglCommon.gl.getProgramParameter(this.FProgramObject,35714)) {
        pas.System.Writeln(pas.wglCommon.gl.getProgramInfoLog(this.FProgramObject));
        pas.wglCommon.gl.deleteProgram(this.FProgramObject);
      };
    };
    this.UseProgram = function () {
      pas.wglCommon.gl.useProgram(this.FProgramObject);
    };
    this.AttribLocation = function (Name) {
      var Result = 0;
      Result = pas.wglCommon.gl.getAttribLocation(this.FProgramObject,Name);
      return Result;
    };
    this.UniformLocation = function (Name) {
      var Result = null;
      Result = pas.wglCommon.gl.getUniformLocation(this.FProgramObject,Name);
      return Result;
    };
  });
});
rtl.module("wglTextur",["System","Types","SysUtils","Web","browserconsole","webgl","JS","wglCommon"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass(this,"TTextur",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.FID = null;
      this.FFileName = "";
    };
    this.$final = function () {
      this.FID = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.Create$1 = function (AFilename) {
      var img = null;
      pas.System.TObject.Create.call(this);
      this.FFileName = AFilename;
      this.FID = null;
      img = document.createElement("img");
      img.setAttribute("id",AFilename);
      img.setAttribute("src",AFilename);
      img.setAttribute("style","display: none;");
      document.body.appendChild(img);
      return this;
    };
    this.Destroy = function () {
      if (this.FID !== null) {
        pas.wglCommon.gl.deleteTexture(this.FID);
      };
      pas.System.TObject.Destroy.call(this);
    };
    this.activateAndBind = function (nr) {
      var im = null;
      if (this.FID === null) {
        im = document.getElementById(this.FFileName);
        if (im.width > 0) {
          this.FID = pas.wglCommon.gl.createTexture();
          pas.wglCommon.gl.bindTexture(3553,this.FID);
          pas.wglCommon.gl.texParameteri(3553,10242,33071);
          pas.wglCommon.gl.texParameteri(3553,10243,33071);
          pas.wglCommon.gl.texParameteri(3553,10241,9729);
          pas.wglCommon.gl.texParameteri(3553,10240,9729);
          pas.wglCommon.gl.texImage2D(3553,0,6408,6408,5121,im);
        };
      } else {
        pas.wglCommon.gl.activeTexture(33984 + nr);
        pas.wglCommon.gl.bindTexture(3553,this.FID);
      };
    };
  });
});
rtl.module("ShaderSource",["System"],function () {
  "use strict";
  var $mod = this;
  this.texturVertex = "           attribute vec3 inPos;" + "\n" + "           attribute vec3 inNormal;" + "\n" + "           attribute vec2 inUV;" + "\n" + "" + "\n" + "           uniform mat4 ObjectMatrix;" + "\n" + "           uniform mat4 WorldMatrix;" + "\n" + "" + "\n" + "           varying vec3 Pos;" + "\n" + "           varying vec3 Normal;" + "\n" + "           varying vec2 UV;" + "\n" + "" + "\n" + "           void main()" + "\n" + "           {" + "\n" + "           UV = inUV;" + "\n" + "           Pos = (ObjectMatrix * vec4(inPos, 1.0)).xyz;" + "\n" + "           Normal = normalize(mat3(ObjectMatrix) * inNormal);" + "\n" + "           gl_Position = ObjectMatrix * vec4(inPos, 1.0);" + "\n" + "           }";
  this.texturFragment = "           precision mediump float;" + "\n" + "" + "\n" + "           varying vec3 Pos;" + "\n" + "           varying vec3 Normal;" + "\n" + "           varying vec2 UV;" + "\n" + "" + "\n" + "           uniform sampler2D Sampler0;" + "\n" + "" + "\n" + "           vec3 LightPosition = vec3(1.0, 1.0, 1.4);" + "\n" + "" + "\n" + "           float UmgebungsLicht = 0.3;" + "\n" + "" + "\n" + "           float diffuse()" + "\n" + "           {" + "\n" + "           vec3 LP        = (LightPosition * 1.0) - Pos;" + "\n" + "           float distance = length(LP);" + "\n" + "           float dif      = max(dot(Normal, LP), UmgebungsLicht);" + "\n" + "           return           dif * (1.0 / (1.0 + (0.25 * distance * distance)));" + "\n" + "           }" + "\n" + "" + "\n" + "           float specular()" + "\n" + "           {" + "\n" + "           vec3 Eye          = normalize(LightPosition);" + "\n" + "           vec3 Reflected    = normalize( reflect( -Pos, Normal ));" + "\n" + "           return              0.15 * pow(max(dot(Reflected, Eye), 0.0), 1.0);" + "\n" + "           }" + "\n" + "" + "\n" + "" + "\n" + "           void main()" + "\n" + "           {" + "\n" + "               vec4 Color = texture2D(Sampler0, UV);" + "\n" + "//                Color.a=1.0;  // ?????" + "\n" + "               float cola = Color.a;" + "\n" + "               gl_FragColor = (Color * diffuse() + specular());" + "\n" + "               gl_FragColor.a = cola;" + "\n" + "           }";
  this.texturBumpMapingVertex = "    attribute vec3 inPos;" + "\n" + "    attribute vec3 inNormal;" + "\n" + "    attribute vec2 inUV;" + "\n" + "" + "\n" + "    uniform mat4 ObjectMatrix;" + "\n" + "    uniform mat4 WorldMatrix;" + "\n" + "" + "\n" + "    varying vec3 Pos;" + "\n" + "    varying vec3 Normal;" + "\n" + "    varying vec2 UV;" + "\n" + "" + "\n" + "    void main()" + "\n" + "    {" + "\n" + "    UV = inUV;" + "\n" + "    Pos = (ObjectMatrix * vec4(inPos, 1.0)).xyz;" + "\n" + "    Normal = normalize(mat3(ObjectMatrix) * inNormal);" + "\n" + "    gl_Position = ObjectMatrix * vec4(inPos, 1.0);" + "\n" + "    }";
  this.texturBumpMapingFragment = "    precision mediump float;" + "\n" + "" + "\n" + "    varying vec3 Pos;" + "\n" + "    varying vec3 Normal;" + "\n" + "    varying vec2 UV;" + "\n" + "" + "\n" + "    uniform sampler2D Sampler0;" + "\n" + "    uniform sampler2D Sampler1;" + "\n" + "" + "\n" + "//            vec3 LightPosition = vec3(1.0, 0.0, 1.4);" + "\n" + "    vec3 LightPosition = vec3(1.0, 1.0, 1.4);" + "\n" + "" + "\n" + "    float UmgebungsLicht = 0.4;" + "\n" + "      vec3  Normal2;" + "\n" + "" + "\n" + "    float diffuse()" + "\n" + "    {" + "\n" + "    vec3 LP        = (LightPosition * 1.0) - Pos;" + "\n" + "    float distance = length(LP);" + "\n" + "    float dif      = max(dot(Normal2, LP), UmgebungsLicht);" + "\n" + "    return           dif * (1.0 / (1.0 + (0.25 * distance* distance)));" + "\n" + "    }" + "\n" + "" + "\n" + "    float specular()" + "\n" + "    {" + "\n" + "    vec3 Eye          = normalize(LightPosition);" + "\n" + "    vec3 Reflected    = normalize( reflect( -Pos, Normal2 ));" + "\n" + "    return              0.15 * pow(max(dot(Reflected, Eye), 0.0), 1.0);" + "\n" + "    }" + "\n" + "" + "\n" + "" + "\n" + "    void main()" + "\n" + "    {" + "\n" + "        Normal2 = (texture2D(Sampler1, UV.st).rgb * 2.0 - 1.0) + normalize(Normal);" + "\n" + "        vec4 Color = texture2D(Sampler0, UV);" + "\n" + "" + "\n" + "        float cola = Color.a;" + "\n" + "" + "\n" + "        gl_FragColor = (Color * diffuse() + specular());" + "\n" + "        gl_FragColor.a = cola;" + "\n" + "    }";
  this.monoColorVertex = "        attribute vec3 inPos;" + "\n" + "        attribute vec3 inNormal;" + "\n" + "" + "\n" + "        uniform mat4 ObjectMatrix;" + "\n" + "        uniform mat4 WorldMatrix;" + "\n" + "        uniform vec4 VecColor;" + "\n" + "" + "\n" + "        varying vec3 Pos;" + "\n" + "        varying vec4 Color;" + "\n" + "        varying vec3 Normal;" + "\n" + "" + "\n" + "        void main()" + "\n" + "        {" + "\n" + "        Pos = (ObjectMatrix * vec4(inPos, 1.0)).xyz;" + "\n" + "        Normal = normalize(mat3(ObjectMatrix) * inNormal);" + "\n" + "        gl_Position = ObjectMatrix * vec4(inPos, 1.0);" + "\n" + "        Color = VecColor;" + "\n" + "        }";
  this.monoColorFragment = "        precision mediump float;" + "\n" + "" + "\n" + "        varying vec3 Pos;" + "\n" + "        varying vec4 Color;" + "\n" + "        varying vec3 Normal;" + "\n" + "" + "\n" + "        vec3 LightPosition = vec3(1.0, 0.0, 1.4);" + "\n" + "" + "\n" + "        float UmgebungsLicht = 0.3;" + "\n" + "" + "\n" + "        float diffuse()" + "\n" + "        {" + "\n" + "        vec3 LP        = (LightPosition * 1.0) - Pos;" + "\n" + "        float distance = length(LP);" + "\n" + "        float dif      = max(dot(Normal, LP), UmgebungsLicht);" + "\n" + "        return           dif * (1.0 / (1.0 + (0.25 * distance * distance)));" + "\n" + "        }" + "\n" + "" + "\n" + "        float specular()" + "\n" + "        {" + "\n" + "        vec3 Eye          = normalize(LightPosition);" + "\n" + "        vec3 Reflected    = normalize( reflect( -Pos, Normal ));" + "\n" + "        return              0.5 * pow(max(dot(Reflected, Eye), 0.0), 1.0);" + "\n" + "        }" + "\n" + "" + "\n" + "" + "\n" + "        void main()" + "\n" + "        {" + "\n" + "        float cola = Color.a;" + "\n" + "        gl_FragColor = (Color * diffuse() + specular());" + "\n" + "        gl_FragColor.a = cola;" + "\n" + "        }";
});
rtl.module("wglVAO",["System","Types","SysUtils","Web","browserconsole","webgl","JS","wglCommon","wglMatrix","wglShader","wglTextur","ShaderSource"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass(this,"TVBO",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.ID = null;
      this.fVertexSize = 0;
    };
    this.$final = function () {
      this.ID = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.Create$1 = function (floatArray, vertexSize) {
      pas.System.TObject.Create.call(this);
      this.fVertexSize = vertexSize;
      this.ID = pas.wglCommon.gl.createBuffer();
      pas.wglCommon.gl.bindBuffer(34962,this.ID);
      pas.wglCommon.gl.bufferData(34962,floatArray,35044);
      return this;
    };
    this.Destroy = function () {
      pas.wglCommon.gl.deleteBuffer(this.ID);
      pas.System.TObject.Destroy.call(this);
    };
    this.Bind = function (uniformID) {
      pas.wglCommon.gl.enableVertexAttribArray(uniformID);
      pas.wglCommon.gl.bindBuffer(34962,this.ID);
      pas.wglCommon.gl.vertexAttribPointer(uniformID,this.fVertexSize,5126,false,0,0);
    };
  });
  rtl.createClass(this,"TVAOMonoColor",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.reader = null;
      this.shader = null;
      this.posID = 0;
      this.normalID = 0;
      this.colorID = null;
      this.matrixID = null;
      this.posVBO = null;
      this.normalVBO = null;
      this.numItems = 0;
      this.Color = rtl.arraySetLength(null,0.0,4);
    };
    this.$final = function () {
      this.reader = undefined;
      this.shader = undefined;
      this.colorID = undefined;
      this.matrixID = undefined;
      this.posVBO = undefined;
      this.normalVBO = undefined;
      this.Color = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.Create$1 = function (VertexPath) {
      this.posVBO = null;
      this.normalVBO = null;
      this.shader = pas.wglShader.TShader.$create("Create$1");
      this.shader.LoadShaderObject(35633,pas.ShaderSource.monoColorVertex);
      this.shader.LoadShaderObject(35632,pas.ShaderSource.monoColorFragment);
      this.shader.LinkProgram();
      this.posID = this.shader.AttribLocation("inPos");
      this.normalID = this.shader.AttribLocation("inNormal");
      this.colorID = this.shader.UniformLocation("VecColor");
      this.matrixID = this.shader.UniformLocation("ObjectMatrix");
      this.reader = new XMLHttpRequest();
      this.reader.addEventListener("load",rtl.createCallback(this,"onload"));
      this.reader.open("GET","data/" + VertexPath + ".bin");
      this.reader.responseType = "arraybuffer";
      this.reader.send(null);
      this.numItems = 0;
      return this;
    };
    this.onload = function () {
      var arrayBuffer = null;
      var floatBufferColor = null;
      var pos = 0;
      var len = 0;
      var i = 0;
      if (this.reader.status === 200) {
        arrayBuffer = this.reader.response;
        floatBufferColor = new Float32Array(arrayBuffer,0,4);
        for (i = 0; i <= 3; i++) {
          this.Color[i] = floatBufferColor[i];
        };
        pos = 4;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.numItems = rtl.trunc(len / 3);
        this.posVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),3]);
        pos += len;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.normalVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),3]);
        pos += len;
      };
    };
    var GoldCol = [1.0,1.0,0.5,1.0];
    this.draw = function () {
      var m = rtl.arraySetLength(null,0.0,4,4);
      this.shader.UseProgram();
      if (this.posVBO !== null) {
        this.posVBO.Bind(this.posID);
      };
      if (this.normalVBO !== null) {
        this.normalVBO.Bind(this.normalID);
      };
      if (pas.wglMatrix.isGold) {
        pas.wglCommon.gl.uniform4fv(this.colorID,GoldCol.slice(0));
      } else {
        pas.wglCommon.gl.uniform4fv(this.colorID,this.Color.slice(0));
      };
      pas.wglMatrix.TMatrixfHelper.Identity.call({get: function () {
          return m;
        }, set: function (v) {
          m = v;
        }});
      m = pas.wglMatrix.MatrixMultiple(pas.wglMatrix.WorldMatrix,pas.wglMatrix.ObjectMatrix);
      pas.wglMatrix.TMatrixfHelper.Uniform.call({get: function () {
          return m;
        }, set: function (v) {
          m = v;
        }},this.matrixID);
      pas.wglCommon.gl.drawArrays(4,0,this.numItems);
    };
    this.setColor = function (Acol) {
      this.Color = pas.wglMatrix.vec4(Acol,1.0);
    };
  });
  rtl.createClass(this,"TVAOTextur",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.reader = null;
      this.shader = null;
      this.posID = 0;
      this.normalID = 0;
      this.uvID = 0;
      this.matrixID = null;
      this.posVBO = null;
      this.normalVBO = null;
      this.uvVBO = null;
      this.numItems = 0;
    };
    this.$final = function () {
      this.reader = undefined;
      this.shader = undefined;
      this.matrixID = undefined;
      this.posVBO = undefined;
      this.normalVBO = undefined;
      this.uvVBO = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.Create$1 = function (VertexPath) {
      this.posVBO = null;
      this.normalVBO = null;
      this.uvVBO = null;
      this.shader = pas.wglShader.TShader.$create("Create$1");
      this.shader.LoadShaderObject(35633,pas.ShaderSource.texturVertex);
      this.shader.LoadShaderObject(35632,pas.ShaderSource.texturFragment);
      this.shader.LinkProgram();
      this.posID = this.shader.AttribLocation("inPos");
      this.normalID = this.shader.AttribLocation("inNormal");
      this.uvID = this.shader.AttribLocation("inUV");
      this.matrixID = this.shader.UniformLocation("ObjectMatrix");
      pas.wglCommon.gl.uniform1i(this.shader.UniformLocation("Sampler0"),0);
      this.reader = new XMLHttpRequest();
      this.reader.addEventListener("load",rtl.createCallback(this,"onload"));
      this.reader.open("GET","data/" + VertexPath + ".bin");
      this.reader.responseType = "arraybuffer";
      this.reader.send(null);
      this.numItems = 0;
      return this;
    };
    this.onload = function () {
      var arrayBuffer = null;
      var pos = 0;
      var len = 0;
      if (this.reader.status === 200) {
        arrayBuffer = this.reader.response;
        pos = 4;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.numItems = rtl.trunc(len / 3);
        this.posVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),3]);
        pos += len;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.normalVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),3]);
        pos += len;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.uvVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),2]);
      };
    };
    this.draw = function (textur) {
      var m = rtl.arraySetLength(null,0.0,4,4);
      this.shader.UseProgram();
      if (this.posVBO !== null) {
        this.posVBO.Bind(this.posID);
      };
      if (this.normalVBO !== null) {
        this.normalVBO.Bind(this.normalID);
      };
      if (this.uvVBO !== null) {
        this.uvVBO.Bind(this.uvID);
      };
      if (textur !== null) {
        textur.activateAndBind(0);
      };
      pas.wglMatrix.TMatrixfHelper.Identity.call({get: function () {
          return m;
        }, set: function (v) {
          m = v;
        }});
      m = pas.wglMatrix.MatrixMultiple(pas.wglMatrix.WorldMatrix,pas.wglMatrix.ObjectMatrix);
      pas.wglMatrix.TMatrixfHelper.Uniform.call({get: function () {
          return m;
        }, set: function (v) {
          m = v;
        }},this.matrixID);
      pas.wglCommon.gl.drawArrays(4,0,this.numItems);
    };
  });
  rtl.createClass(this,"TVAOBumpMapingTextur",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.reader = null;
      this.shader = null;
      this.posID = 0;
      this.normalID = 0;
      this.uvID = 0;
      this.matrixID = null;
      this.posVBO = null;
      this.normalVBO = null;
      this.uvVBO = null;
      this.numItems = 0;
    };
    this.$final = function () {
      this.reader = undefined;
      this.shader = undefined;
      this.matrixID = undefined;
      this.posVBO = undefined;
      this.normalVBO = undefined;
      this.uvVBO = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.Create$1 = function (VertexPath) {
      this.posVBO = null;
      this.normalVBO = null;
      this.uvVBO = null;
      this.shader = pas.wglShader.TShader.$create("Create$1");
      this.shader.LoadShaderObject(35633,pas.ShaderSource.texturBumpMapingVertex);
      this.shader.LoadShaderObject(35632,pas.ShaderSource.texturBumpMapingFragment);
      this.shader.LinkProgram();
      this.posID = this.shader.AttribLocation("inPos");
      this.normalID = this.shader.AttribLocation("inNormal");
      this.uvID = this.shader.AttribLocation("inUV");
      this.matrixID = this.shader.UniformLocation("ObjectMatrix");
      pas.wglCommon.gl.uniform1i(this.shader.UniformLocation("Sampler0"),0);
      pas.wglCommon.gl.uniform1i(this.shader.UniformLocation("Sampler1"),1);
      this.reader = new XMLHttpRequest();
      this.reader.addEventListener("load",rtl.createCallback(this,"onload"));
      this.reader.open("GET","data/" + VertexPath + ".bin");
      this.reader.responseType = "arraybuffer";
      this.reader.send(null);
      this.numItems = 0;
      return this;
    };
    this.onload = function () {
      var arrayBuffer = null;
      var floatBufferColor = null;
      var pos = 0;
      var len = 0;
      if (this.reader.status === 200) {
        arrayBuffer = this.reader.response;
        floatBufferColor = new Float32Array(arrayBuffer,0,4);
        pos = 0;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.numItems = rtl.trunc(len / 3);
        this.posVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),3]);
        pos += len;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.normalVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),3]);
        pos += len;
        len = rtl.trunc((new Uint32Array(arrayBuffer))[pos] / 4);
        pos += 1;
        this.uvVBO = $mod.TVBO.$create("Create$1",[new Float32Array(arrayBuffer,pos * 4,len),2]);
      };
    };
    this.draw = function (textur, normal) {
      var m = rtl.arraySetLength(null,0.0,4,4);
      this.shader.UseProgram();
      if (this.posVBO !== null) {
        this.posVBO.Bind(this.posID);
      };
      if (this.normalVBO !== null) {
        this.normalVBO.Bind(this.normalID);
      };
      if (this.uvVBO !== null) {
        this.uvVBO.Bind(this.uvID);
      };
      if (textur !== null) {
        textur.activateAndBind(0);
      };
      if (normal !== null) {
        normal.activateAndBind(1);
      };
      pas.wglMatrix.TMatrixfHelper.Identity.call({get: function () {
          return m;
        }, set: function (v) {
          m = v;
        }});
      m = pas.wglMatrix.MatrixMultiple(pas.wglMatrix.WorldMatrix,pas.wglMatrix.ObjectMatrix);
      pas.wglMatrix.TMatrixfHelper.Uniform.call({get: function () {
          return m;
        }, set: function (v) {
          m = v;
        }},this.matrixID);
      pas.wglCommon.gl.drawArrays(4,0,this.numItems);
    };
  });
});
rtl.module("Masse",["System","Types","SysUtils","Web","browserconsole","webgl","JS","wglCommon","wglMatrix","wglShader","wglTextur","ShaderSource"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass(this,"TVLIMasse",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.reader = null;
      this.L = 0.0;
      this.C1 = 0.0;
      this.C2 = 0.0;
      this.t = 0.0;
      this.Schienenlaenge = 0.0;
      this.AussenD = 0.0;
      this.InnenD = 0.0;
      this.anzKugeln = 0;
      this.SchwimmerAussenD = 0.0;
      this.anzFluegeli = 0;
    };
    this.$final = function () {
      this.reader = undefined;
      pas.System.TObject.$final.call(this);
    };
    this.Create$1 = function () {
      pas.System.TObject.Create.call(this);
      this.reader = new XMLHttpRequest();
      this.reader.addEventListener("load",rtl.createCallback(this,"onload"));
      this.reader.open("GET","data/VLIMasse.bin");
      this.reader.responseType = "arraybuffer";
      this.reader.send(null);
      return this;
    };
    this.onload = function () {
      var arrayBuffer = null;
      var floatBuffer = null;
      var intBuffer = null;
      arrayBuffer = this.reader.response;
      floatBuffer = new Float32Array(arrayBuffer);
      intBuffer = new Int32Array(arrayBuffer);
      this.L = floatBuffer[0];
      this.C1 = floatBuffer[1];
      this.C2 = floatBuffer[2];
      this.t = floatBuffer[3];
      this.Schienenlaenge = floatBuffer[4];
      this.AussenD = floatBuffer[5];
      this.InnenD = floatBuffer[6];
      this.anzKugeln = intBuffer[7];
      this.SchwimmerAussenD = floatBuffer[8];
      this.anzFluegeli = Math.round(this.Schienenlaenge / 10);
    };
  });
});
rtl.module("program",["System","browserconsole","BrowserApp","JS","Classes","SysUtils","Web","webgl","wglCommon","wglShader","wglMatrix","wglVAO","wglTextur","ShaderSource","Masse"],function () {
  "use strict";
  var $mod = this;
  this.canvas = null;
  this.VLIMasse = null;
  this.BackGroundBuffer = null;
  this.GlobusBuffer = null;
  this.WorldAllTextur = null;
  this.GlobusTextur = null;
  this.GlobusNormal = null;
  this.CloudsTextur = null;
  this.CloudsNormal = null;
  this.FluegeliBuffer = null;
  this.InnenProfilBuffer = null;
  this.InnenProfilSchnittBuffer = null;
  this.ProcessFlanschSchnittBuffer = null;
  this.ProcessFlanschBuffer = null;
  this.RohrFlanschSchnittBuffer = null;
  this.RohrFlanschBuffer = null;
  this.StutzenSchnittBuffer = null;
  this.StutzenBuffer = null;
  this.StandRohrSchnittBuffer = null;
  this.StandRohrBuffer = null;
  this.SchwimmerSchnittBuffer = null;
  this.SchwimmerBuffer = null;
  this.DichtungProcessFlanschSchnittBuffer = null;
  this.DichtungProcessFlanschBuffer = null;
  this.DichtungRohrFlanschSchnittBuffer = null;
  this.DichtungRohrFlanschBuffer = null;
  this.WasserUntenBuffer = null;
  this.WasserSchwimmerSchnittBuffer = null;
  this.WasserSchwimmerBuffer = null;
  this.isFrontFace = false;
  this.Niveau = 0;
  this.NiveauRichtung = true;
  rtl.recNewT(this,"MousePos$a",function () {
    this.X = 0.0;
    this.Y = 0.0;
    this.$eq = function (b) {
      return (this.X === b.X) && (this.Y === b.Y);
    };
    this.$assign = function (s) {
      this.X = s.X;
      this.Y = s.Y;
      return this;
    };
  });
  this.MousePos = this.MousePos$a.$clone({X: 0, Y: 0});
  var TransFactor = 10.0;
  var RotFactor = 0.1;
  this.ButtonClick = function (aEvent) {
    var Result = false;
    var id = undefined;
    id = aEvent.target["id"];
    if (id == "A-") {
      pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},-0.1);
    };
    id = aEvent.target["id"];
    if (id == "A+") {
      pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0.1);
    };
    if (id == "B-") {
      pas.wglMatrix.TMatrixfHelper.RotateB.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},-0.1);
    };
    id = aEvent.target["id"];
    if (id == "B+") {
      pas.wglMatrix.TMatrixfHelper.RotateB.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0.1);
    };
    if (id == "C-") {
      pas.wglMatrix.TMatrixfHelper.RotateC.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},-0.1);
    };
    id = aEvent.target["id"];
    if (id == "C+") {
      pas.wglMatrix.TMatrixfHelper.RotateC.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0.1);
    };
    if (id == "X-") {
      pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},-10,0,0);
    };
    if (id == "X+") {
      pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},10,0,0);
    };
    if (id == "Y-") {
      pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0,-10,0);
    };
    if (id == "Y+") {
      pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0,10,0);
    };
    if (id == "Z-") {
      pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0,0,-10);
    };
    if (id == "Z+") {
      pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0,0,10);
    };
    Result = true;
    return Result;
  };
  this.onwheel = function (aEvent) {
    var Result = false;
    if (aEvent.deltaY < 0) {
      pas.wglMatrix.TMatrixfHelper.Scale$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},1.1);
    } else {
      pas.wglMatrix.TMatrixfHelper.Scale$1.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},0.9);
    };
    Result = true;
    return Result;
  };
  this.onmousedown = function (aEvent) {
    var Result = false;
    if ((aEvent.offsetX < 7) && (aEvent.offsetY < 7)) {
      pas.wglMatrix.isGold = !pas.wglMatrix.isGold;
    };
    pas.wglMatrix.Geschnitten = !pas.wglMatrix.Geschnitten;
    Result = true;
    return Result;
  };
  this.onmousemove = function (Event) {
    var Result = false;
    Event.preventDefault();
    var $tmp = Event.buttons;
    if ($tmp === 1) {
      pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},[Event.clientX - $mod.MousePos.X,-(Event.clientY - $mod.MousePos.Y),0.0]);
    } else if ($tmp === 2) {
      pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},(Event.clientY - $mod.MousePos.Y) / 200);
      pas.wglMatrix.TMatrixfHelper.RotateB.call({p: pas.wglMatrix, get: function () {
          return this.p.mRotationMatrix;
        }, set: function (v) {
          this.p.mRotationMatrix = v;
        }},(Event.clientX - $mod.MousePos.X) / 200);
    };
    $mod.MousePos.X = Event.clientX;
    $mod.MousePos.Y = Event.clientY;
    Result = true;
    return Result;
  };
  var ButtonCaption = ["X-","X+","Y+","Y-","Z+","Z-","A-","A+","B+","B-","C+","C-"];
  this.Create = function () {
    var Button = null;
    var Panel = null;
    var div1 = null;
    var i = 0;
    function ButtonInit(titel) {
      var Result = null;
      Result = document.createElement("input");
      Result.setAttribute("id",titel);
      Result.setAttribute("class","favorite styled");
      Result.setAttribute("type","button");
      Result.setAttribute("value",titel);
      Result.setAttribute("style","height:25px;width:30px;color=#00ff00;background-color:#FFBBBB;");
      Panel.appendChild(Result);
      return Result;
    };
    Panel = document.createElement("div");
    Panel.setAttribute("class","panel panel-default");
    document.body.appendChild(Panel);
    div1 = document.createElement("div");
    div1.innerHTML = "<b>WebGL VLI-Demo</b>";
    Panel.appendChild(div1);
    for (i = 0; i <= 11; i++) {
      Button = ButtonInit(ButtonCaption[i]);
      Button.onclick = rtl.createSafeCallback($mod,"ButtonClick");
      if (i === 5) {
        Panel.appendChild(document.createElement("div"));
      };
    };
    $mod.canvas = document.createElement("canvas");
    $mod.canvas.width = 800;
    $mod.canvas.height = 800;
    $mod.canvas.onwheel = rtl.createSafeCallback($mod,"onwheel");
    $mod.canvas.onmousedown = rtl.createSafeCallback($mod,"onmousedown");
    $mod.canvas.onmousemove = rtl.createSafeCallback($mod,"onmousemove");
    document.body.appendChild($mod.canvas);
    pas.wglCommon.gl = $mod.canvas.getContext("webgl2",pas.JS.New(["depth",true,"antialias",true,"alpha",false]));
    if (pas.wglCommon.gl === null) {
      pas.System.Writeln("failed to load webgl!");
      return;
    };
    pas.wglCommon.gl.clearColor(0.0,0.0,0.0,1.0);
    pas.wglCommon.gl.enable(2929);
    pas.wglCommon.gl.depthFunc(513);
    pas.wglCommon.gl.enable(2884);
    pas.wglCommon.gl.cullFace(1029);
    pas.wglCommon.gl.enable(3042);
    pas.wglCommon.gl.blendFunc(770,771);
    pas.wglCommon.gl.viewport(0,0,$mod.canvas.width,$mod.canvas.height);
    $mod.VLIMasse = pas.Masse.TVLIMasse.$create("Create$1");
    $mod.BackGroundBuffer = pas.wglVAO.TVAOTextur.$create("Create$1",["BackGround"]);
    $mod.WorldAllTextur = pas.wglTextur.TTextur.$create("Create$1",["data/all.jpg"]);
    $mod.GlobusBuffer = pas.wglVAO.TVAOBumpMapingTextur.$create("Create$1",["Earth"]);
    $mod.GlobusTextur = pas.wglTextur.TTextur.$create("Create$1",["data/earth_textur.jpg"]);
    $mod.GlobusNormal = pas.wglTextur.TTextur.$create("Create$1",["data/earth_normal.jpg"]);
    $mod.CloudsTextur = pas.wglTextur.TTextur.$create("Create$1",["data/clouds_textur.png"]);
    $mod.CloudsNormal = pas.wglTextur.TTextur.$create("Create$1",["data/clouds_normal.jpg"]);
    $mod.FluegeliBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["Fluegeli"]);
    $mod.InnenProfilBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["InnenProfil"]);
    $mod.InnenProfilSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["InnenProfilSchnitt"]);
    $mod.ProcessFlanschSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["ProcessFlanschSchnitt"]);
    $mod.ProcessFlanschBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["ProcessFlansch"]);
    $mod.RohrFlanschSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["RohrFlanschSchnitt"]);
    $mod.RohrFlanschBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["RohrFlansch"]);
    $mod.StutzenSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["StutzenSchnitt"]);
    $mod.StutzenBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["Stutzen"]);
    $mod.StandRohrSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["StandRohrSchnitt"]);
    $mod.StandRohrBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["StandRohr"]);
    $mod.SchwimmerSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["SchwimmerSchnitt"]);
    $mod.SchwimmerBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["Schwimmer"]);
    $mod.DichtungProcessFlanschSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["DichtungProcessFlanschSchnitt"]);
    $mod.DichtungProcessFlanschBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["DichtungProcessFlansch"]);
    $mod.DichtungRohrFlanschSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["DichtungRohrFlanschSchnitt"]);
    $mod.DichtungRohrFlanschBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["DichtungRohrFlansch"]);
    $mod.WasserUntenBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["WasserUnten"]);
    $mod.WasserSchwimmerSchnittBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["WasserSchwimmerSchnitt"]);
    $mod.WasserSchwimmerBuffer = pas.wglVAO.TVAOMonoColor.$create("Create$1",["WasserSchwimmer"]);
    pas.wglMatrix.TMatrixfHelper.Perspective.call({p: pas.wglMatrix, get: function () {
        return this.p.mProjectionMatrix;
      }, set: function (v) {
        this.p.mProjectionMatrix = v;
      }},30,1.0,0.1,100.0);
    pas.wglMatrix.TMatrixfHelper.TranslateLocalspace.call({p: pas.wglMatrix, get: function () {
        return this.p.mProjectionMatrix;
      }, set: function (v) {
        this.p.mProjectionMatrix = v;
      }},0,-0.4,-5);
    pas.wglMatrix.TMatrixfHelper.Scale$1.call({p: pas.wglMatrix, get: function () {
        return this.p.mProjectionMatrix;
      }, set: function (v) {
        this.p.mProjectionMatrix = v;
      }},0.004);
    pas.wglMatrix.TMatrixfHelper.RotateB.call({p: pas.wglMatrix, get: function () {
        return this.p.mRotationMatrix;
      }, set: function (v) {
        this.p.mRotationMatrix = v;
      }},-0.6);
  };
  this.drawBackGround = function () {
    var dummyMatrix = rtl.arraySetLength(null,0.0,4,4);
    var rotMatrix = rtl.arraySetLength(null,0.0,4,4);
    dummyMatrix = pas.wglMatrix.TMatrix$clone(pas.wglMatrix.WorldMatrix);
    pas.wglMatrix.TMatrixfHelper.Identity.call({get: function () {
        return rotMatrix;
      }, set: function (v) {
        rotMatrix = v;
      }});
    pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }});
    pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }},[1,1,-1]);
    pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }});
    $mod.BackGroundBuffer.draw($mod.WorldAllTextur);
    pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }});
    pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }},0.0,0.0,0.99);
    pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }},[1.5,1.5,0.01]);
    pas.wglMatrix.TMatrixfHelper.RotateB.call({p: pas.wglMatrix, get: function () {
        return this.p.GlobusMatrix;
      }, set: function (v) {
        this.p.GlobusMatrix = v;
      }},-0.005);
    pas.wglMatrix.ObjectMatrix = pas.wglMatrix.MatrixMultiple(rotMatrix,pas.wglMatrix.GlobusMatrix);
    $mod.GlobusBuffer.draw($mod.GlobusTextur,$mod.GlobusNormal);
    pas.wglMatrix.TMatrixfHelper.RotateB.call({p: pas.wglMatrix, get: function () {
        return this.p.CloudsMatrix;
      }, set: function (v) {
        this.p.CloudsMatrix = v;
      }},-0.006);
    pas.wglMatrix.ObjectMatrix = pas.wglMatrix.MatrixMultiple(rotMatrix,pas.wglMatrix.CloudsMatrix);
    pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
        return this.p.WorldMatrix;
      }, set: function (v) {
        this.p.WorldMatrix = v;
      }},0.0,0.0,-0.01);
    $mod.GlobusBuffer.draw($mod.CloudsTextur,$mod.CloudsNormal);
    pas.wglMatrix.WorldMatrix = pas.wglMatrix.TMatrix$clone(dummyMatrix);
  };
  this.SwapFrontFace = function () {
    $mod.isFrontFace = !$mod.isFrontFace;
    if (!$mod.isFrontFace) {
      pas.wglCommon.gl.frontFace(2305);
    } else {
      pas.wglCommon.gl.frontFace(2304);
    };
  };
  this.DrawElement = function (Koerper, Schnitt, geschnitten) {
    Koerper.draw();
    if (geschnitten) {
      if (Schnitt !== null) {
        Schnitt.draw();
      };
    } else {
      pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[-1,1,1]);
      $mod.SwapFrontFace();
      Koerper.draw();
      $mod.SwapFrontFace();
    };
    pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }});
  };
  this.RenderScene = function (OMatrix) {
    var i = 0;
    var FlugelWinkel = 0.0;
    pas.wglMatrix.WorldMatrix = pas.wglMatrix.TMatrix$clone(OMatrix);
    pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }});
    for (var $l = -5, $end = $mod.VLIMasse.anzFluegeli - 6; $l <= $end; $l++) {
      i = $l;
      FlugelWinkel = ((($mod.Niveau / 10.0) - i) * 30) + 90;
      if (FlugelWinkel > 180.0) {
        FlugelWinkel = 180.0;
      };
      if (FlugelWinkel < 0.0) {
        FlugelWinkel = 0.0;
      };
      pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[0.0,(10.0 * i) + 5,($mod.VLIMasse.AussenD / 2) + 10]);
      pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},(FlugelWinkel / 180) * Math.PI);
      if (i > 0) {
        $mod.FluegeliBuffer.setColor(pas.wglMatrix.vec3white.slice(0));
      } else {
        $mod.FluegeliBuffer.setColor(pas.wglMatrix.vec3red.slice(0));
      };
      $mod.FluegeliBuffer.draw();
      pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[-1.0,-1.0,1.0]);
      $mod.FluegeliBuffer.draw();
      if (i > 0) {
        $mod.FluegeliBuffer.setColor(pas.wglMatrix.vec3yellow.slice(0));
      } else {
        $mod.FluegeliBuffer.setColor(pas.wglMatrix.vec3green.slice(0));
      };
      pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[1.0,-1.0,-1.0]);
      $mod.FluegeliBuffer.draw();
      pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[-1.0,-1.0,1.0]);
      $mod.FluegeliBuffer.draw();
      pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }});
    };
    pas.wglMatrix.TMatrixfHelper.Translate$1.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},0,0,$mod.VLIMasse.AussenD / 2);
    $mod.DrawElement($mod.InnenProfilBuffer,$mod.InnenProfilSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Identity.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }});
    $mod.DrawElement($mod.StandRohrBuffer,$mod.StandRohrSchnittBuffer,pas.wglMatrix.Geschnitten);
    $mod.DrawElement($mod.StutzenBuffer,$mod.StutzenSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,$mod.VLIMasse.L,0.0]);
    $mod.DrawElement($mod.StutzenBuffer,$mod.StutzenSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,0.0,-$mod.VLIMasse.t]);
    pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},Math.PI / 2);
    $mod.DrawElement($mod.ProcessFlanschBuffer,$mod.ProcessFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,$mod.VLIMasse.L,-$mod.VLIMasse.t]);
    pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},Math.PI / 2);
    $mod.DrawElement($mod.ProcessFlanschBuffer,$mod.ProcessFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,-$mod.VLIMasse.C1,0.0]);
    $mod.DrawElement($mod.RohrFlanschBuffer,$mod.RohrFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,$mod.VLIMasse.L + $mod.VLIMasse.C2,0.0]);
    pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},Math.PI);
    $mod.DrawElement($mod.RohrFlanschBuffer,$mod.RohrFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,0.0,-$mod.VLIMasse.t - 2.0]);
    pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},Math.PI / 2);
    $mod.DrawElement($mod.DichtungProcessFlanschBuffer,$mod.DichtungProcessFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,$mod.VLIMasse.L,-$mod.VLIMasse.t - 2.0]);
    pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},Math.PI / 2);
    $mod.DrawElement($mod.DichtungProcessFlanschBuffer,$mod.DichtungProcessFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,-$mod.VLIMasse.C1 - 2.0,0.0]);
    $mod.DrawElement($mod.DichtungRohrFlanschBuffer,$mod.DichtungRohrFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},[0.0,$mod.VLIMasse.L + $mod.VLIMasse.C2 + 2.0,0.0]);
    pas.wglMatrix.TMatrixfHelper.RotateA.call({p: pas.wglMatrix, get: function () {
        return this.p.ObjectMatrix;
      }, set: function (v) {
        this.p.ObjectMatrix = v;
      }},Math.PI);
    $mod.DrawElement($mod.DichtungRohrFlanschBuffer,$mod.DichtungRohrFlanschSchnittBuffer,pas.wglMatrix.Geschnitten);
    if (pas.wglMatrix.Geschnitten) {
      pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[0.0,$mod.Niveau,0.0]);
      $mod.DrawElement($mod.SchwimmerBuffer,$mod.SchwimmerSchnittBuffer,false);
      pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[0.0,$mod.Niveau,0.0]);
      $mod.DrawElement($mod.WasserSchwimmerBuffer,$mod.WasserSchwimmerSchnittBuffer,true);
      pas.wglMatrix.TMatrixfHelper.Translate.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[0.0,-$mod.VLIMasse.C1,-$mod.VLIMasse.InnenD / 2]);
      pas.wglMatrix.TMatrixfHelper.Scale.call({p: pas.wglMatrix, get: function () {
          return this.p.ObjectMatrix;
        }, set: function (v) {
          this.p.ObjectMatrix = v;
        }},[1.0,($mod.VLIMasse.C1 + $mod.Niveau + ($mod.VLIMasse.SchwimmerAussenD / 2)) - ($mod.VLIMasse.SchwimmerAussenD * $mod.VLIMasse.anzKugeln),$mod.VLIMasse.InnenD]);
      $mod.DrawElement($mod.WasserUntenBuffer,null,true);
    };
  };
  this.UpdateCanvas = function (time) {
    var scretch = rtl.arraySetLength(null,0.0,4,4);
    if ($mod.NiveauRichtung) {
      $mod.Niveau += 0.7;
      if ($mod.Niveau > ($mod.VLIMasse.L + 30)) {
        $mod.NiveauRichtung = false;
      };
    } else {
      $mod.Niveau -= 0.7;
      if ($mod.Niveau < -30) {
        $mod.NiveauRichtung = true;
      };
    };
    pas.wglCommon.gl.clear(16384 | 256);
    pas.wglCommon.gl.clearColor(0.7,0.5,0.2,1.0);
    $mod.drawBackGround();
    scretch = pas.wglMatrix.MatrixMultiple(pas.wglMatrix.mProjectionMatrix,pas.wglMatrix.mRotationMatrix);
    $mod.RenderScene(pas.wglMatrix.TMatrix$clone(scretch));
    window.requestAnimationFrame($mod.UpdateCanvas);
  };
  $mod.$main = function () {
    $mod.Create();
    window.requestAnimationFrame($mod.UpdateCanvas);
  };
});
//# sourceMappingURL=project1.js.map
