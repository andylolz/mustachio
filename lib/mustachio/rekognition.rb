module Mustachio
  class Rekognition
    class << self

      REKOGNITION_KEY = ENV['MUSTACHIO_REKOGNITION_KEY'] || raise('please set MUSTACHIO_REKOGNITION_KEY')
      REKOGNITION_SECRET = ENV['MUSTACHIO_REKOGNITION_SECRET'] || raise('please set MUSTACHIO_REKOGNITION_SECRET')

      # return tuple [rekognition_json, rekognition_width, rekognition_height]
      def data file
        json = self.json file
        width, height = self.dims file
        [json, width, height]
      end

      def json file, jobs = 'face'
        conn = Faraday.new :url => 'https://rekognition.com' do |faraday|
          faraday.request :multipart
          faraday.request :url_encoded
          faraday.adapter :excon
        end

        payload = {
          :api_key       => REKOGNITION_KEY,
          :api_secret    => REKOGNITION_SECRET,
          :uploaded_file => Faraday::UploadIO.new(file, content_type(file)),
          :jobs          => jobs,
          :name_space    => '',
          :user_id       => ''
        }

        response = conn.post '/func/api/', payload

        JSON.parse response.body
      end

      def dims file
        `identify -format "%wx%h" #{file.path}`.strip.split('x').map(&:to_f)
      end

      def content_type file
        `file -b --mime #{file.path}`.strip.split(/[:;]\s+/)[0]
      end

      def face_detection file
        json = self.json file, 'face_part'
        width, height = self.dims file

        json['face_detection'].map do |entry|
          eye_left, eye_right, nose = entry.values_at('eye_left', 'eye_right', 'nose').map do |dims|
            {
              'x' => ((dims['x'].to_f / width) * 100.0),
              'y' => ((dims['y'].to_f / height) * 100.0)
            }
          end

          face_tl =
            {
              'x' => ((entry['boundingbox']['tl']['x'].to_f / width) * 100.0),
              'y' => ((entry['boundingbox']['tl']['y'].to_f / height) * 100.0)
            }

          face_size =
            {
              'x' => ((entry['boundingbox']['size']['width'].to_f / width) * 100.0),
              'y' => ((entry['boundingbox']['size']['height'].to_f / height) * 100.0)
            }

          puts face_size

          { 'eye_left' => eye_left, 'eye_right' => eye_right, 'nose' => nose, 'face_tl' => face_tl, 'face_size' => face_size }
        end
      end
    end
  end
end
