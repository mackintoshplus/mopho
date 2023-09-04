# -*- coding: utf-8 -*-

import imageio
import numpy as np
import sys

def morph_images(image1_path, image2_path, output_path, steps=30):
    image1 = imageio.imread(image1_path)
    image2 = imageio.imread(image2_path)
    
    # 出力用のリストを用意
    result_images = []

    # モーフィングの各ステップでの画像を生成
    for step in range(steps):
        alpha = step / float(steps - 1)
        morphed_image = (1 - alpha) * image1 + alpha * image2
        result_images.append((morphed_image / 255.0).astype(np.float32))
    
    # MP4として出力
    imageio.mimwrite(output_path, result_images, fps=30)

if __name__ == "__main__":
    input1, input2, output = sys.argv[1], sys.argv[2], sys.argv[3]
    morph_images(input1, input2, output)
    print(f"Processing {input1} and {input2} to {output}")  # デバッグ出力
