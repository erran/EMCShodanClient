# vi: set ft=ruby :

Pod::Spec.new do |s|
  s.name         = 'ECShodanClient'
  s.version      = '0.1.0'
  s.homepage     = 'https://github.com/ipwnstuff/ECShodanClient'
  s.screenshots  = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.author       = {
    'Erran Carey' => 'me@errancarey.com'
  }
  s.license      = 'MIT'
  s.summary      = 'A short description of ECShodanClient.'
#  s.description  = <<-DESC
#                    An optional longer description of ECShodanClient
#
#                    * Markdown format.
#                    * Don't worry about the indent, we strip it!
#                   DESC
  s.source       = {
    git: 'https://github.com/ipwnstuff/ECShodanClient.git',
    tag: s.version
  }
  s.source_files = 'ECShodanClient'
  s.requires_arc = true

  # [todo] - Update the required versions if AFNetworking is used
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'


# [todo] - Use AFNetworking?
#  s.dependency 'AFNetworking', '~> 2.0'
end
