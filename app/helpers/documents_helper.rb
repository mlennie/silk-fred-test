module DocumentsHelper

  def montage_text
    montage_url.nil? ? "Loading ..." : montage_url
  end
end
