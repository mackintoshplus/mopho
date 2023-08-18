class MorphingService

  def self.call_python_morph_script(image1_path, image2_path, output_path)
    require 'open3'
    script_path = Rails.root.join('lib', 'morph.py').to_s
    Open3.popen3("python #{script_path} #{image1_path} #{image2_path} #{output_path}") do |stdin, stdout, stderr, thread|
      # スクリプトからの出力を取得
      output = stdout.read.strip
      error = stderr.read.strip

      # エラーがあればログに出力
      Rails.logger.error("Python Morphing Error: #{error}") unless error.blank?
    end
  end
end
