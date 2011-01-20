# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rank/version"

Gem::Specification.new do |s|
  s.name        = "rank"
  s.version     = Rank::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Pan Thomakos"]
  s.email       = ["pan.thomakos@gmail.com"]
  s.homepage    = "http://github.com/panthomakos/rank"
  s.summary     = "rank-#{Rank::VERSION}"
  s.description = %q{Easily add rankings to arrays of objects.}

  s.rubyforge_project = "rank"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.extra_rdoc_files = ['README.markdown', 'License.txt']
  s.rdoc_options = ['--charset=UTF-8']
  s.require_paths = ["lib"]
end
