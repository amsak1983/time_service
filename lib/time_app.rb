# frozen_string_literal: true

class TimeApp
  FORMAT_MAP = {
    'year' => '%Y',
    'month' => '%m',
    'day' => '%d',
    'hour' => '%H',
    'minute' => '%M',
    'second' => '%S'
  }.freeze

  ALLOWED = FORMAT_MAP.keys.freeze

  def call(env)
    req = Rack::Request.new(env)

    return not_found unless req.get? && req.path_info == '/time'

    formats = parse_formats(req.params['format'])
    return bad_request('Missing format parameter') if formats.empty?

    unknown = formats - ALLOWED
    return bad_request("Unknown time format [#{unknown.join(', ')}]") if unknown.any?

    ok build_time(formats)
  end

  private

  def parse_formats(param)
    Array(param).flat_map { |s| s.split(',') }.map(&:strip).reject(&:empty?)
  end

  def build_time(formats)
    now = Time.now
    formats.map { |f| now.strftime(FORMAT_MAP[f]) }.join('-')
  end

  def ok(body)         = response(200, body)
  def bad_request(msg) = response(400, msg)
  def not_found = response(404, 'Not Found')

  def response(code, body)
    [code, { 'content-type' => 'text/plain', 'content-length' => body.bytesize.to_s }, [body]]
  end
end
