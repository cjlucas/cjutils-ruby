module CJUtils
  module Path
    def uri_to_path(uri)
      sanitize_path(URI.unescape(uri.path))
    end

    def sanitize_path(path)
      path.squeeze(::File::SEPARATOR).chomp(::File::SEPARATOR)
    end
  end
end
