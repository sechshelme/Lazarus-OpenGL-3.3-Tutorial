void
VSShaderLib::addBlocks() {

	int count, dataSize, actualLen, activeUnif, maxUniLength;
	int uniType, uniSize, uniOffset, uniMatStride, uniArrayStride, auxSize;
	char *name, *name2;

	UniformBlock block;

	glGetProgramiv(pProgram, GL_ACTIVE_UNIFORM_BLOCKS, &count);

	for (int i = 0; i < count; ++i) {
		// Get buffers name
		glGetActiveUniformBlockiv(pProgram, i, GL_UNIFORM_BLOCK_NAME_LENGTH, &actualLen);
		name = (char *)malloc(sizeof(char) * actualLen);
		glGetActiveUniformBlockName(pProgram, i, actualLen, NULL, name);

		if (!spBlocks.count(name)) {
			// Get buffers size
			block = spBlocks[name];
			glGetActiveUniformBlockiv(pProgram, i, GL_UNIFORM_BLOCK_DATA_SIZE, &dataSize);
			//printf("DataSize:%d\n", dataSize);
			glGenBuffers(1, &block.buffer);
			glBindBuffer(GL_UNIFORM_BUFFER, block.buffer);
			glBufferData(GL_UNIFORM_BUFFER, dataSize, NULL, GL_DYNAMIC_DRAW);
			glUniformBlockBinding(pProgram, i, spBlockCount);
			glBindBufferRange(GL_UNIFORM_BUFFER, spBlockCount, block.buffer, 0, dataSize);

			glGetActiveUniformBlockiv(pProgram, i, GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS, &activeUnif);

			unsigned int *indices;
			indices = (unsigned int *)malloc(sizeof(unsigned int) * activeUnif);
			glGetActiveUniformBlockiv(pProgram, i, GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES, (int *)indices);
			
			glGetProgramiv(pProgram, GL_ACTIVE_UNIFORM_MAX_LENGTH, &maxUniLength);
			name2 = (char *)malloc(sizeof(char) * maxUniLength);

			for (int k = 0; k < activeUnif; ++k) {
		
				myBlockUniform bUni;

				glGetActiveUniformName(pProgram, indices[k], maxUniLength, &actualLen, name2);
				glGetActiveUniformsiv(pProgram, 1, &indices[k], GL_UNIFORM_TYPE, &uniType);
				glGetActiveUniformsiv(pProgram, 1, &indices[k], GL_UNIFORM_SIZE, &uniSize);
				glGetActiveUniformsiv(pProgram, 1, &indices[k], GL_UNIFORM_OFFSET, &uniOffset);
				glGetActiveUniformsiv(pProgram, 1, &indices[k], GL_UNIFORM_MATRIX_STRIDE, &uniMatStride);
				glGetActiveUniformsiv(pProgram, 1, &indices[k], GL_UNIFORM_ARRAY_STRIDE, &uniArrayStride);
			
				if (uniArrayStride > 0)
					auxSize = uniArrayStride * uniSize;
				
				else if (uniMatStride > 0) {

					switch(uniType) {
						case GL_FLOAT_MAT2:
						case GL_FLOAT_MAT2x3:
						case GL_FLOAT_MAT2x4:
						case GL_DOUBLE_MAT2:
						case GL_DOUBLE_MAT2x3:
						case GL_DOUBLE_MAT2x4:
							auxSize = 2 * uniMatStride;
							break;
						case GL_FLOAT_MAT3:
						case GL_FLOAT_MAT3x2:
						case GL_FLOAT_MAT3x4:
						case GL_DOUBLE_MAT3:
						case GL_DOUBLE_MAT3x2:
						case GL_DOUBLE_MAT3x4:
							auxSize = 3 * uniMatStride;
							break;
						case GL_FLOAT_MAT4:
						case GL_FLOAT_MAT4x2:
						case GL_FLOAT_MAT4x3:
						case GL_DOUBLE_MAT4:
						case GL_DOUBLE_MAT4x2:
						case GL_DOUBLE_MAT4x3:
							auxSize = 4 * uniMatStride;
							break;
					}
				}
				else
					auxSize = typeSize(uniType);

				bUni.offset = uniOffset;
				bUni.type = uniType;
				bUni.size = auxSize;
				bUni.arrayStride = uniArrayStride;

				block.uniformOffsets[name2] = bUni;


			}
			free(name2);

			block.size = dataSize;
			block.bindingIndex = spBlockCount;
			spBlocks[name] = block;
			spBlockCount++;
		}
		else
			glUniformBlockBinding(pProgram, i, spBlocks[name].bindingIndex);

	}

}
