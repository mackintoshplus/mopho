class MorphImagesController < ApplicationController

  def new
    @morph_image = MorphImage.new
  end

 
    def create
      @morph_image = MorphImage.new(morph_image_params)
      if @morph_image.save
        image1_path = Rails.root.join('tmp', 'image1.png')
        image2_path = Rails.root.join('tmp', 'image2.png')
        output_path = Rails.root.join('tmp', 'output.mp4')
    
        # 画像を一時的な場所に保存
        File.open(image1_path, 'wb') do |file|
          file.write(@morph_image.image.download)
        end
    
        File.open(image2_path, 'wb') do |file|
          file.write(@morph_image.image2.download)
        end
    
        # モーフィング処理を実行
        MorphingService.call_python_morph_script(image1_path.to_s, image2_path.to_s, output_path.to_s)
    
        # 最後に一時的な画像ファイルを削除
        File.delete(image1_path) if File.exist?(image1_path)
        File.delete(image2_path) if File.exist?(image2_path)
    
        redirect_to @morph_image, notice: 'Image was successfully uploaded.'
      else
        render :new
      end
    end

 

  def show
    @morph_image = MorphImage.find(params[:id])
  end

  private

  def morph_image_params
    params.require(:morph_image).permit(:image, :image2) # image2を追加
  end
  
end
