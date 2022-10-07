#
# Be sure to run `pod lib lint CertificatePinner.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CertificatePinner'
  s.version          = '1.0.0'
  s.summary          = 'CertificatePinner is a helper library for SSL pinning written in swift.'
  s.description      = <<-DESC
  CertificatePinner provides an elegant way for certificate pinning (for now only public key pinning) in order to prevent man-in-the-middle attack.
                       DESC

  s.homepage         = 'https://github.com/micho233/certificate-pinner'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mirsad Arslanovic' => 'mirsad.arslanovic@gmail.com' }
  s.source           = { :git => 'https://github.com/micho233/certificate-pinner.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/Hepek233'

  s.ios.deployment_target = '10.0'
  s.source_files = 'Sources/**/*'
end
