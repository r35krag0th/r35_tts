function round(number, decimals)
  local scale = 10^decimals
  local c = 2^52 + 2^51
  return ((number * scale + c ) - c) / scale
end
