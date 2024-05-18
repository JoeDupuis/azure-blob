# frozen_string_literal: true

require "test_helper"
require "securerandom"

class Azure::TestClient < Minitest::Test
  def setup
    @account_name = ENV["AZURE_ACCOUNT_NAME"]
    @access_key = ENV["AZURE_ACCESS_KEY"]
  end

  def test_upload
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "random name"
    data = "hello world!"

    pp "end_result:", client.create_block_blob("dev", key, StringIO.new(data), max_block_size: 1, metadata: {:lol => 123, "no" => :qwe})
  end

  def test_upload_prefix
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "some prefix/inside the prefix #{Random.rand(20)}"
    data = "hello world!"

    pp "end_result:", client.create_block_blob("dev", key, StringIO.new(data), max_block_size: 1, metadata: {:lol => 123, "no" => :qwe})
  end


  def test_upload_multiple
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "multiple"
    data = "hello world!"

    pp "end_result:", client.create_block_blob("dev", key, StringIO.new(data), max_block_size: 6, metadata: {:lol => 123, "no" => :qwe}, content_type: "lol", content_disposition: "inline")
  end

  def test_upload
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "random name"
    data = "hello world!"

    pp "end_result:", client.create_block_blob("dev", key, StringIO.new(data))
  end

  def test_download
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "random name"
    data = "hello world!"

    pp "end_result:", client.get_blob("dev", key)
  end

  def test_download_chunk
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "random name"
    data = "hello world!"

    pp "end_result:", client.get_blob("dev", key, start_range: 0, end_range: 3)
  end

  def test_download_chunk_endless
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "random name"
    data = "hello world!"

    pp "end_result:", client.get_blob("dev", key, start_range: 3)
  end

  def test_delete
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )
    key = "random name"

    pp "end_result:", client.delete_blob("dev", key)
  end

  def test_list_blobs_prefix
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )

    pp "end_result:", client.list_blobs("dev", prefix: 'some prefix/')
  end

  def test_list_blobs_root
    client = Azure::ActiveStorage::Client.new(
      account_name: @account_name,
      access_key: @access_key
    )

    pp "end_result:", client.list_blobs("dev")
  end
end
