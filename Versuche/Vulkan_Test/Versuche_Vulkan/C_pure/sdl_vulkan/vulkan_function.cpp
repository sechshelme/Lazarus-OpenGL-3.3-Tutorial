#include "vulkan_function.h"

#include "vulkan_extern.h"
extern Vulkan *vulkan;

uint32_t frameIndex;
VkCommandBuffer commandBuffer;
VkImage image;
void AcquireNextImage()
{
    vkAcquireNextImageKHR(  vulkan->device,
                            vulkan->swapchain,
                            UINT64_MAX,
                            vulkan->imageAvailableSemaphore,
                            VK_NULL_HANDLE,
                            &frameIndex);

    vkWaitForFences(vulkan->device, 1, &vulkan->fences[frameIndex], VK_FALSE, UINT64_MAX);
    vkResetFences(vulkan->device, 1, &vulkan->fences[frameIndex]);  

    commandBuffer = vulkan->commandBuffers[frameIndex];
    image = vulkan->swapchainImages[frameIndex];
}

void ResetCommandBuffer()
{
    vkResetCommandBuffer(commandBuffer, 0);
}

void BeginCommandBuffer()
{
    VkCommandBufferBeginInfo beginInfo = {};
    beginInfo.sType = VK_STRUCTURE_TYPE_COMMAND_BUFFER_BEGIN_INFO;
    beginInfo.flags = VK_COMMAND_BUFFER_USAGE_SIMULTANEOUS_USE_BIT;
    vkBeginCommandBuffer(commandBuffer, &beginInfo);
}

void EndCommandBuffer()
{
    vkEndCommandBuffer(commandBuffer);
}

void FreeCommandBuffers()
{
    vkFreeCommandBuffers(vulkan->device, vulkan->commandPool, 1, &commandBuffer);
}

void BeginRenderPass(VkClearColorValue clear_color,VkClearDepthStencilValue clear_depth_stencil)
{
	VkRenderPassBeginInfo render_pass_info = {};
	render_pass_info.sType = VK_STRUCTURE_TYPE_RENDER_PASS_BEGIN_INFO;
	render_pass_info.renderPass        = vulkan->render_pass;render_pass_info.framebuffer       = vulkan->swapchainFramebuffers[frameIndex];
	render_pass_info.renderArea.offset = {0, 0};
	render_pass_info.renderArea.extent = vulkan->swapchainSize;
	render_pass_info.clearValueCount   = 1;

	vector<VkClearValue> clearValues(2);
    clearValues[0].color = clear_color;
    clearValues[1].depthStencil = clear_depth_stencil;

    render_pass_info.clearValueCount = static_cast<uint32_t>(clearValues.size());
    render_pass_info.pClearValues = clearValues.data();
	
    vkCmdBeginRenderPass(commandBuffer, &render_pass_info, VK_SUBPASS_CONTENTS_INLINE);
}

void EndRenderPass()
{
    vkCmdEndRenderPass(commandBuffer);
}

VkPipelineStageFlags waitDestStageMask = VK_PIPELINE_STAGE_TRANSFER_BIT;
void QueueSubmit()
{
    VkSubmitInfo submitInfo = {};
    submitInfo.sType = VK_STRUCTURE_TYPE_SUBMIT_INFO;
    submitInfo.waitSemaphoreCount = 1;
    submitInfo.pWaitSemaphores = &vulkan->imageAvailableSemaphore;
    submitInfo.pWaitDstStageMask = &waitDestStageMask;
    submitInfo.commandBufferCount = 1;
    submitInfo.pCommandBuffers = &commandBuffer;
    submitInfo.signalSemaphoreCount = 1;
    submitInfo.pSignalSemaphores = &vulkan->renderingFinishedSemaphore;
    vkQueueSubmit(vulkan->graphicsQueue, 1, &submitInfo, vulkan->fences[frameIndex]);
}

void QueuePresent()
{
    VkPresentInfoKHR presentInfo = {};
    presentInfo.sType = VK_STRUCTURE_TYPE_PRESENT_INFO_KHR;
    presentInfo.waitSemaphoreCount = 1;
    presentInfo.pWaitSemaphores = &vulkan->renderingFinishedSemaphore;
    presentInfo.swapchainCount = 1;
    presentInfo.pSwapchains = &vulkan->swapchain;
    presentInfo.pImageIndices = &frameIndex;
    vkQueuePresentKHR(vulkan->presentQueue, &presentInfo);

    vkQueueWaitIdle(vulkan->presentQueue);
}

void SetViewport(int width,int height)
{
    VkViewport viewport;
    viewport.width = (float)width / 2;
    viewport.height = (float)height;
    viewport.minDepth = (float)0.0f;
    viewport.maxDepth = (float)1.0f;
    viewport.x = 0;
    viewport.y = 0;
    vkCmdSetViewport(commandBuffer, 0, 1, &viewport);
}

void SetScissor(int width,int height)
{
    VkRect2D scissor;
    scissor.extent.width = width / 2;
    scissor.extent.height = height;
    scissor.offset.x = 0;
    scissor.offset.y = 0;
    vkCmdSetScissor(commandBuffer, 0, 1, &scissor);
}