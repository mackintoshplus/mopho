# -*- coding: utf-8 -*-
import imageio
import numpy as np
import sys

def morph_images(image1_path, image2_path, output_path, steps=30):
    image1 = imageio.v2.imread(image1_path).astype(np.float32) / 255.0  # 修正
    image2 = imageio.v2.imread(image2_path).astype(np.float32) / 255.0  # 修正
    
    result_images = []
    
    for step in range(steps):
        alpha = step / float(steps - 1)
        morphed_image = (1 - alpha) * image1 + alpha * image2
        result_images.append((morphed_image * 255).astype(np.uint8))  # 修正
    
    imageio.mimwrite(output_path, result_images, fps=30, codec="libx264")

if __name__ == "__main__":
    input1, input2, output = sys.argv[1], sys.argv[2], sys.argv[3]
    morph_images(input1, input2, output)