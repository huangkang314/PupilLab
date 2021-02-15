function norm_data = norm_01(data)

norm_data = (data - min(data)) / ( max(data) - min(data) );