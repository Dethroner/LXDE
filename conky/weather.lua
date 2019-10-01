require 'cairo'

-- функция перекодировки цвета, глобальная для всех функций
function rgb_to_r_g_b(colour,fgaha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., fgaha
end
-- ------------------------------------------

--[[ WEATHER ]]
function weather (cr, x, y, w, font, bgc, bga, fgc, fga)

-- высота виджета погоды равна ширине виджета
--	h = w

-- назначаем вид шрифта и цвет
	cairo_select_font_face(cr, font, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD)
	cairo_set_source_rgba(cr, rgb_to_r_g_b(fgc, fga))

-- вычисляем размер шрифта относительно ширине окна
--	local dpi = tonumber(conky_parse('${exec xdpyinfo | grep resolution | cut -c 18-19}'))
	local font_pixel_size = w / 8
	local font_size = font_pixel_size * 72 / 96 --dpi

-- Забираем данные с http://weather.noaa.gov/, переводим на русский, переводим вывод давления в миллиметры ртутного столба, добавляем иконки.
-- температура
text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS temperature}°C')
-- устанавливаем размер шрифта
	cairo_set_font_size(cr, font_size * 2.25)
-- выводим текст
	cairo_move_to(cr, x + 4.3 * w / 8, y + 2.3 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- давление
	cairo_set_font_size(cr, font_size * 0.9)
	text = "Давление:"
	cairo_move_to(cr, x + 1 * w / 8, y + 6.5 * w / 8) --4.5
	cairo_text_path(cr, text)
	cairo_fill(cr)
	text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS pressure} ГПа')
	cairo_move_to(cr, x + 5.5 * w / 8, y + 6.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- влажность
	text = "Влажность:"
	cairo_move_to(cr, x + 1 * w / 8, y + 5.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)
	text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS humidity} %')
	cairo_move_to(cr, x + 5.5 * w / 8, y + 5.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

--направление ветра
	text = "Ветер:   "
	cairo_move_to(cr, x + 1 * w / 8, y + 4.5 * w / 8) --6.5
	cairo_text_path(cr, text)
	cairo_fill(cr)
	text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS wind_dir}')
--	if text == "SSW" then text = "ЮЮВ" image = 25 end
	if text == "N" then text = "С" end
	if text == "S" then text = "Ю" end
	if text == "W" then text = "З" end
	if text == "E" then text = "В" end
	if text == "NW" then text = "СЗ" end
	if text == "NE" then text = "СВ" end
	if text == "SW" then text = "ЮЗ" end
	if text == "SE" then text = "ЮВ" end
	if text == "NNW" then text = "ССЗ" end
	if text == "NNE" then text = "ССВ" end
	if text == "SSW" then text = "ЮЮЗ" end
	if text == "SSE" then text = "ЮЮВ" end
	
	cairo_move_to(cr, x + 3.5 * w / 8, y + 4.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- скорость ветра
	text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS wind_speed} m/s')
	cairo_move_to(cr, x + 5.5 * w / 8, y + 4.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- обновление
--	cairo_set_font_size(cr, font_size* 0.4)
	text = conky_parse('Up:  ${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS last_update} UTC')
	cairo_move_to(cr, x + 1 * w / 8, y + 7.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- перевод и вывод иконок
	cairo_set_font_size(cr, font_size* 0.8)

-- погода
	text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS cloud_cover}')

	if text == "" then image = 21 end
	if text == "cloudy" then text = "Облачно" image = 26 end
	if text == "overcast" then text = "Облачно"	image = 26 end
	if text == "partly cloudy" then text = "Облачно" image = 29 end	-- ночь
	if text == "partly cloudy" then text = "Облачно" image = 30 end	-- день
	if text == "clear" then text = "Ясно" image = 31 end	-- ночь
	if text == "sunny" then text = "Ясно" image = 32 end	-- день

	cairo_move_to(cr, x + 1 * w / 8, y + 3.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- осадки
	text = conky_parse('${weather http://tgftp.nws.noaa.gov/data/observations/metar/stations/ UMMS weather}')
	if text == "drizzle" then text = "Морось" image = 9 end
	if text == "freezing rain" then text = "Дождь" image = 10 end
	if text == "showers" then text = "Снегопад" image = 11 end
	if text == "snow" then text = "Снег" image = 16 end
	if text == "rain" then text = "Дождь" image = 11 end
	if text == "fog" then text = "Туман" image = 20 end
	if text == "mist" then text = "Дымка" image = 21 end

	cairo_move_to(cr, x + 4 * w / 8, y + 3.5 * w / 8)
	cairo_text_path(cr, text)
	cairo_fill(cr)

-- иконки
-- создаём имидж изображения
	image_bg = cairo_image_surface_create_from_png ("/etc/conky/60x60/" .. image .. ".png")

-- забираем данные о ширине и высоте изображения из образа
	w1 = cairo_image_surface_get_width (image_bg)
	h1 = cairo_image_surface_get_height (image_bg)

-- т.к. начальная точка, левый верхний угол, вывода изображения находится в левом верхнем углу окна конки, переносим изображение
	cairo_translate (cr, x + w/8, y + w/8)

-- масштабтруем изображение
	cairo_scale (cr, (w/4)/w1, (w/4)/h1)

-- выводим изображение
	cairo_set_source_surface (cr, image_bg, 0, 0)
	cairo_paint (cr)
	cairo_surface_destroy (image_bg)

end

 -------------------------------------------------------------------------------------
	function conky_widgets()
		if conky_window == nil then return end
		local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
-- -------------------------------------------------------------------------------------
-- вывод погоды
	cr = cairo_create (cs)
	weather (cr, 145, 10, 110, "DejaVu Sans Mono", 0x151515, 1, 0xffffff, 1)
	cairo_destroy(cr)
end

  -- ["AM Snow Showers"]   = "Утром снегопад",
  -- ["AM Light Snow"]   = "Утром снег",
  -- ["Blowing Snow"]   = "Поземка",
  -- ["Blustery"]    = "Ветрено",
  -- ["Broken Clouds"]   = "Временами облачно",
  -- ["Calm"]     = "Штиль",
  -- ["Clear"]     = "Ясно",
  -- ["Cloudy"]     = "Облачно",
  -- ["Clouds Early"]   = "Облачно",
  -- ["Drifting Snow"]   = "Поземка",
  -- ["Drizzle"]     = "Моросящий дождь",
  -- ["Dust"]     = "Пыль",
  -- ["Fair"]     = "Ясно",
  -- ["Few Clouds"]    = "Небольшая облачность",
  -- ["Few Snow Showers"]  = "Небольшой снегопад",
  -- ["Fog"]      = "Густой туман",
  -- ["Freezing Drizzle"]  = "Изморозь",
  -- ["Freezing Rain"]   = "Леденой дождь",
  -- ["Hail"]     = "Град",
  -- ["Haze"]     = "Дымка",
  -- ["Heavy Rain"]    = "Сильный дождь",
  -- ["Heavy Snow"]    = "Сильный снег",
  -- ["High"]     = "высокий",
  -- ["Hot"]      = "Жара",
  -- ["Hurricane"]    = "Ураган",
  -- ["Ice Pellets"]    = "Леденая крупа",
  -- ["Isolated Thunderstorms"] = "Временами грозы",
  -- ["Light Fog"]    = "Небольшой туман",
  -- ["Light Rain"]    = "Небольшой дождь",
  -- ["Light Snow"]    = "Небольшой снег",
  -- ["Light Snow Showers"]  = "Сильный снегопад",
  -- ["Low"]      = "низкий",
  -- ["Mixed Precipitation"]  = "Смешанные осадки",
  -- ["Mixed Rain and Hail"]  = "Дождь с градом",
  -- ["Mixed Rain and Sleet"] = "Дождь с мокрым снегом",
  -- ["Mixed Rain and Snow"]  = "Дождь со снегом",
  -- ["Moderate Snow"]   = "Умеренный снег",
  -- ["Mostly Clear"]   = "Переменная облачность",
  -- ["Mostly Cloudy"]   = "Переменная облачность",
  -- ["Mostly Sunny"]   = "Преимуществеено солнечно",
  -- ["Overcast"]    = "Облачно",
  -- ["Partly Cloudy"]   = "Переменная облачность",
  -- ["PM Snow Showers"]   = "Ночью снегопад",
  -- ["Rain"]     = "Дождь",
  -- ["Rain Showers"]   = "Ливни",
  -- ["Scattered Clouds"]  = "Местами облачно",
  -- ["Scattered Showers"]  = "Местами грозы",
  -- ["Scattered Snow Showers"] = "Местами снег",
  -- ["Severe Thunderstorms"] = "Сильный дождь",
  -- ["Scattered Thunderstorms"] = "Местами грозы",
  -- ["Sleet"]     = "Гололед",
  -- ["Smoke"]     = "Туман",
  -- ["Snow"]     = "Снег",
  -- ["Snow Flurries"]   = "Снегопад",
  -- ["Snow Showers"]   = "Снег",
  -- ["Snow Showers Early"]  = "Утром снегопад",
  -- ["Snow Showers Late"]  = "Позднее снег",
  -- ["Sunny"]     = "Солнечно",
  -- ["Thunderstorms"]   = "Гроза",
  -- ["Tornado"]     = "Торнадо",
  -- ["Tropical Storm"]   = "Тропический шторм",
  -- ["Windy"]     = "Ветер",