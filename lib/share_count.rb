require 'rest-client'
require 'json'
require 'share_count/string_helper'
require 'share_count/base'
require 'share_count/facebook'
require 'share_count/google'
require 'share_count/linkedin'
require 'share_count/pinterest'
require 'share_count/reddit'
require 'share_count/twitter'
require 'share_count/weibo'
module ShareCount
  # class << self
  include ShareCount::StringHelper
  def config=(val)
    ShareCount::Base.config = val
  end
  NETWORK_LIST = [
    :facebook,
    :google,
    # :linkedin,
    # :pinterest,
    :reddit,
    # :twitter,
    :weibo
  ]
  def supported_networks
    NETWORK_LIST
  end
  NETWORK_LIST.each do |network_name|
    define_method(network_name) do |url|
      class_name = to_camel_case(network_name.to_s)
      ShareCount.const_get(class_name).new(url).shares
    end
    define_method("#{network_name}!") do |url|
      class_name = to_camel_case(network_name.to_s)
      ShareCount.const_get(class_name).new(url).shares!
    end
  end
  def omit(url, excluded_networks = [])
    selected_base(url, NETWORK_LIST.map(&:to_s) - excluded_networks.map(&:to_s), false)
  end
  def omit!(url, excluded_networks = [])
    selected_base(url, NETWORK_LIST.map(&:to_s) - excluded_networks.map(&:to_s), true)
  end
  def selected(url, selected_networks)
    selected_base(url, selected_networks, false)
  end
  def selected!(url, selected_networks)
    selected_base(url, selected_networks, true)
  end
  def all(url)
    selected(url, NETWORK_LIST)
  end
  def all!(url)
    selected!(url, NETWORK_LIST)
  end
  def total(url, selected_networks = NETWORK_LIST)
    selected!(url, selected_networks).values.reduce(:+)
  end
  def has_any?(url, selected_networks = NETWORK_LIST)
    lambdas = filtered_networks(selected_networks).map do |network_name|
      -> {self.send("#{network_name}!", url)}
    end
    pool = thread_pool(lambdas)
    found = false
    while !pool.empty? && !found
      sleep 0.05
      if thread = pool.find(&:stop?)
        if thread.value > 0
          pool.each(&:kill)
          found = true
        else
          pool.delete(thread)
        end
      end
    end
    found
  end
  private
  def filtered_networks(selected_networks)
    selected_networks.map(&:to_s) & NETWORK_LIST.map(&:to_s)
  end
  def thread_pool(lambdas)
    lambdas.map { |l| Thread.new { l.call } }
  end
  def selected_base(url, selected_networks, with_exception)
    lambdas = filtered_networks(selected_networks).map do |network_name|
      method_name = with_exception ? "#{network_name}!" : network_name
      -> {{network_name => self.send(method_name, url)}}
    end
    thread_pool(lambdas).reduce({}) do |result, thread|
      thread.join
      result.merge(thread.value)
    end
  end
  # end
end
