###
##
###
Pod::Spec.new do |spec|

  spec.name         = "YDB2WServices"
  spec.version      = "1.0.0"
  spec.summary      = "A short description of YDB2WServices."
  spec.homepage     = "http://yourdev//YDB2WServices"
  spec.license      = "MIT"
  spec.author       = { "Douglas Hennrich" => "douglashennrich@yourdev.com.br" }

  spec.swift_version    = "5.0"
  spec.platform         = :ios, "11.0"

  spec.source = { :git => "git@github.com:Hennrich-Your-Dev/YDB2WServices.git", :tag => "#{spec.version}" }

  spec.source_files = "YDB2WServices/**/*.{h,m,swift}"

  spec.dependency "Alamofire", "~> 4.0"

  spec.dependency "YDB2WIntegration"
  spec.dependency "YDB2WModels"

end
