class ColorPaletteComponent < ApplicationComponent
  attr_reader :palette

  DEFAULT_PALETTE = %w(#d73a4a #0075ca #cfd3d7 #7057FF #008672 #d876e3 #e99695 #5319e7 #fef2c0 #c2e0c6 #bfdadc #c5def5 #bfd4f2 #d4c5f9 #f9d0c4 #fef3c7)

  def initialize(palette: nil)
    @palette = palette
  end

  def color_palette
    palette ? palette : DEFAULT_PALETTE
  end
end
