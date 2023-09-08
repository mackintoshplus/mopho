class MorphImagesController < ApplicationController

  def new
    @morph_image = MorphImage.new
  end

  def create
    uploaded_io1 = morph_image_params[:image]
    uploaded_io2 = morph_image_params[:image2]

    # nil チェック
    if uploaded_io1.nil? || uploaded_io2.nil?
      flash[:error] = "Both images must be uploaded."
      render :new and return
    end
    
    # タイムスタンプを変数に格納
    timestamp = Time.now.to_i

    # 新しいディレクトリを作成
    dir_path = Rails.root.join('public', 'videos', "morphing_#{timestamp}")
    Dir.mkdir(dir_path) unless Dir.exist?(dir_path)
    
    filepath1 = dir_path.join(uploaded_io1.original_filename)
    filepath2 = dir_path.join(uploaded_io2.original_filename)
    
    File.open(filepath1, 'wb') { |file| file.write(uploaded_io1.read) }
    File.open(filepath2, 'wb') { |file| file.write(uploaded_io2.read) }
    
    output_path = dir_path.join("output_#{timestamp}.mp4")
    success = MorphingService.call_python_morph_script(filepath1, filepath2, output_path)
    
    if success && File.exist?(output_path)
      @video_url = "#{dir_path}/output_#{timestamp}.mp4"
      render :show
    else
      flash[:error] = "An error occurred while generating the video."
      render :new
    end
  end

  private
  
  def morph_image_params
    params.require(:morph_image).permit(:image, :image2)
  end
end
