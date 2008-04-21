require 'libtorrent'
require 'test/unit'

include Libtorrent

class TestFingerprint < Test::Unit::TestCase
  def setup
    @name = "AZ"
    @major_version = 1
    @minor_version = 2
    @revision_version = 3
    @tag_version = 4
    @fingerprint = Fingerprint.new(@name, @major_version, @minor_version, @revision_version, @tag_version)
  end

  def test_name
    assert_equal(@name, @fingerprint.name)
    
    @fingerprint.name = "ZA"
    assert_equal("ZA", @fingerprint.name)
  end

  def test_major_version
    assert_equal(@major_version, @fingerprint.major_version)

    number = rand(9)
    @fingerprint.major_version = number
    assert_equal(number, @fingerprint.major_version)
  end

  def test_minor_version
    assert_equal(@minor_version, @fingerprint.minor_version)

    number = rand(9)
    @fingerprint.minor_version = number
    assert_equal(number, @fingerprint.minor_version)
  end

  def test_revision_version
    assert_equal(@revision_version, @fingerprint.revision_version)

    number = rand(9)
    @fingerprint.revision_version = number
    assert_equal(number, @fingerprint.revision_version)
  end

  def test_tag_version
    assert_equal(@tag_version, @fingerprint.tag_version)

    number = rand(9)
    @fingerprint.tag_version = number
    assert_equal(number, @fingerprint.tag_version)
  end

  def test_to_s
    assert_equal("-AZ1234-", @fingerprint.to_s)
  end
end
