namespace :aws do
  desc 'Create an S3 bucket with public access'

  # IMPORTANT: Update bucket name in credentials.yml.enc first
  task create_s3_bucket: :environment do
    access_key_id = Rails.application.credentials.dig(:aws, :access_key_id)
    secret_access_key = Rails.application.credentials.dig(:aws, :secret_access_key)
    bucket_name = Rails.application.credentials.dig(:aws, :bucket_name)
    script_path = Rails.root.join('lib', 'create_s3_bucket.sh')

    system({ 'AWS_ACCESS_KEY_ID' => access_key_id, 'AWS_SECRET_ACCESS_KEY' => secret_access_key },
           "bash #{script_path} #{bucket_name}")
  end
end
