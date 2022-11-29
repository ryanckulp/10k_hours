module SettingsHelper
  ASSET_DIMENSIONS = {
    'avatar' => '250x250px',
    'banner' => '1488x200px',
    'open_graph' => '1200x630px'
  }

  def asset_label(asset)
    label = asset.name.titleize
    label += " (#{asset_dimensions(asset.name)})"
    label += asset.present? ? ' - exists' : ' - missing'
    label
  end

  def asset_dimensions(asset)
    ASSET_DIMENSIONS[asset]
  end
end
