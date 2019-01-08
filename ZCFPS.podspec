Pod::Spec.new do |s|
  s.name         = "ZCFPS"
  s.version      = "1.0"
  s.summary      = "FPS detect"
  s.homepage     = "https://github.com/Yzc-jason/ZCFPS"
  s.license      = "MIT"
  s.authors      = { 'jasonye' => 'yzc0253@gmail.com'}
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Yzc-jason/ZCFPS.git", :tag => s.version }
  s.source_files = 'ZCFPS/ZCFPS/**/*.{h,m}'
  s.requires_arc = true
end
