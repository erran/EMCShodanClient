Pod::Spec.new do |s|
  s.name         = 'ECShodanClient'
  s.version      = '0.1.0'
  s.homepage     = 'https://github.com/ipwnstuff/ECShodanClient'
  s.author       = {
    'Erran Carey' => 'me@errancarey.com'
  }
  s.license      = 'MIT'
  s.summary      = 'A ShodanHQ API client written in Objective-C.'
  s.description  = <<-DESC
                   A ShodanHQ API client written in Objective-C.
                   ECShodanClient supports all of the standard Shodan API methods.

                   **Caveats**:
                   * Exploit API support not yet available
                   DESC
  s.source       = {
    git: 'https://github.com/ipwnstuff/ECShodanClient.git',
    tag: s.version.to_s
  }
  s.source_files = 'ECShodanClient'
  s.requires_arc = true

  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
end
