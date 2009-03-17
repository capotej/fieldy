# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{fieldy}
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["jcapote"]
  s.date = %q{2009-03-17}
  s.description = %q{Declartive DSL for handling fixed width records, read and write with ease}
  s.email = %q{jcapote@gmail.com}
  s.files = ["README.markdown", "VERSION.yml", "lib/fieldy.rb", "lib/reader.rb", "lib/writer.rb", "test/fixtures", "test/helper.rb", "test/test_reader.rb", "test/test_writer.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jcapote/fieldy}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Read and write fixed width record with ease}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
