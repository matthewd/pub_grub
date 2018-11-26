$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'minitest'
require "pub_grub"
require "pub_grub/rubygems"

PubGrub.logger.level = Logger::DEBUG if ENV['DEBUG']

module PubGrubAssertions
  def assert_solution(source, result, expected)
    expected = Hash[
      expected.map do |package, version|
        [source.package(package), Gem::Version.new(version)]
      end
    ]
    expected[PubGrub::Package.root] = PubGrub::Package.root_version

    assert_equal expected, result
  end
end

Minitest::Test.include(PubGrubAssertions)

require "minitest/autorun"
