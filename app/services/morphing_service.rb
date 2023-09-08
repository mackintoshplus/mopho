class MorphingService
  def self.call_python_morph_script(image1_path, image2_path, output_path)
    require 'open3'
    script_path = Rails.root.join('lib', 'morph.py').to_s
    
    success = true
    
    Open3.popen3("/usr/bin/python3 #{script_path} #{image1_path} #{image2_path} #{output_path}") do |stdin, stdout, stderr, thread|
      # スクリプトからの出力を取得
      output = stdout.read.strip
      error = stderr.read.strip
      
       # デバッグ出力
      puts "Python Output: #{output}"

      # エラーがあればログに出力
      unless error.blank?
        Rails.logger.error("Python Morphing Error: #{error}")
        success = false
      end
    end
    
    success
  end
end