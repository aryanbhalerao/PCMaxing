-- PCMaxing Migration: Add Card Length to GPUs + New Categories
-- Run this in your Supabase SQL editor or via: supabase db push

-- ── Update GPUs to add Card Length (for compatibility check) ─────────────────
UPDATE components SET details = details || '{"Card Length":"150mm"}' WHERE category='GPU' AND name='NVIDIA GeForce GTX 1650 4GB';
UPDATE components SET details = details || '{"Card Length":"168mm"}' WHERE category='GPU' AND name='AMD Radeon RX 6500 XT 4GB';
UPDATE components SET details = details || '{"Card Length":"242mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 3050 8GB';
UPDATE components SET details = details || '{"Card Length":"238mm"}' WHERE category='GPU' AND name='AMD Radeon RX 6600 8GB';
UPDATE components SET details = details || '{"Card Length":"267mm"}' WHERE category='GPU' AND name='AMD Radeon RX 6650 XT 8GB';
UPDATE components SET details = details || '{"Card Length":"285mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 3060 12GB';
UPDATE components SET details = details || '{"Card Length":"240mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 3060 Ti 8GB';
UPDATE components SET details = details || '{"Card Length":"267mm"}' WHERE category='GPU' AND name='AMD Radeon RX 6700 XT 12GB';
UPDATE components SET details = details || '{"Card Length":"285mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 3070 8GB';
UPDATE components SET details = details || '{"Card Length":"310mm"}' WHERE category='GPU' AND name='AMD Radeon RX 6800 XT 16GB';
UPDATE components SET details = details || '{"Card Length":"336mm"}' WHERE category='GPU' AND name='AMD Radeon RX 7900 GRE 16GB';
UPDATE components SET details = details || '{"Card Length":"320mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 3080 10GB';
UPDATE components SET details = details || '{"Card Length":"285mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 4070 12GB';
UPDATE components SET details = details || '{"Card Length":"336mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 4080 16GB';
UPDATE components SET details = details || '{"Card Length":"338mm"}' WHERE category='GPU' AND name='NVIDIA GeForce RTX 4090 24GB';


-- ── Motherboard (15) ─────────────────────────────────────────────────────────
INSERT INTO components (category, name, price, details) VALUES

-- AM4 (DDR4)
('Motherboard', 'MSI PRO B450M-A PRO MAX', 6500,
 '{"Socket":"AM4","Chipset":"B450","Form Factor":"mATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"1","M.2 Slots":"1"}'),

('Motherboard', 'ASRock B450M Steel Legend', 7500,
 '{"Socket":"AM4","Chipset":"B450","Form Factor":"mATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"2","M.2 Slots":"2"}'),

('Motherboard', 'Gigabyte B550M DS3H', 8000,
 '{"Socket":"AM4","Chipset":"B550","Form Factor":"mATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"1","M.2 Slots":"2"}'),

('Motherboard', 'MSI MAG B550 TOMAHAWK', 12000,
 '{"Socket":"AM4","Chipset":"B550","Form Factor":"ATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"2","M.2 Slots":"2"}'),

('Motherboard', 'ASUS ROG Strix B550-F Gaming', 16000,
 '{"Socket":"AM4","Chipset":"B550","Form Factor":"ATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"2","M.2 Slots":"2"}'),

('Motherboard', 'MSI MPG X570 Gaming Edge', 18000,
 '{"Socket":"AM4","Chipset":"X570","Form Factor":"ATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"2","M.2 Slots":"2"}'),

-- AM5 (DDR5)
('Motherboard', 'MSI PRO B650M-A WiFi', 14000,
 '{"Socket":"AM5","Chipset":"B650","Form Factor":"mATX","RAM Type":"DDR5","RAM Slots":"4","Max RAM":"192GB","PCIe x16 Slots":"1","M.2 Slots":"2"}'),

('Motherboard', 'ASRock B650M Pro RS WiFi', 15500,
 '{"Socket":"AM5","Chipset":"B650","Form Factor":"mATX","RAM Type":"DDR5","RAM Slots":"4","Max RAM":"192GB","PCIe x16 Slots":"1","M.2 Slots":"3"}'),

('Motherboard', 'Gigabyte B650 AORUS Elite AX', 20000,
 '{"Socket":"AM5","Chipset":"B650","Form Factor":"ATX","RAM Type":"DDR5","RAM Slots":"4","Max RAM":"192GB","PCIe x16 Slots":"2","M.2 Slots":"3"}'),

('Motherboard', 'MSI MAG B650 TOMAHAWK WiFi', 22000,
 '{"Socket":"AM5","Chipset":"B650","Form Factor":"ATX","RAM Type":"DDR5","RAM Slots":"4","Max RAM":"192GB","PCIe x16 Slots":"2","M.2 Slots":"3"}'),

('Motherboard', 'ASUS ROG Strix X670E-F Gaming', 35000,
 '{"Socket":"AM5","Chipset":"X670E","Form Factor":"ATX","RAM Type":"DDR5","RAM Slots":"4","Max RAM":"192GB","PCIe x16 Slots":"3","M.2 Slots":"4"}'),

-- LGA1700 (Intel 12th/13th Gen)
('Motherboard', 'MSI PRO H610M-G', 8500,
 '{"Socket":"LGA1700","Chipset":"H610","Form Factor":"mATX","RAM Type":"DDR4","RAM Slots":"2","Max RAM":"64GB","PCIe x16 Slots":"1","M.2 Slots":"1"}'),

('Motherboard', 'Gigabyte B660M DS3H DDR4', 9500,
 '{"Socket":"LGA1700","Chipset":"B660","Form Factor":"mATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"1","M.2 Slots":"2"}'),

('Motherboard', 'ASUS PRIME Z690-P D4', 16500,
 '{"Socket":"LGA1700","Chipset":"Z690","Form Factor":"ATX","RAM Type":"DDR4","RAM Slots":"4","Max RAM":"128GB","PCIe x16 Slots":"2","M.2 Slots":"4"}'),

('Motherboard', 'MSI MPG Z790 Carbon WiFi', 38000,
 '{"Socket":"LGA1700","Chipset":"Z790","Form Factor":"ATX","RAM Type":"DDR5","RAM Slots":"4","Max RAM":"192GB","PCIe x16 Slots":"2","M.2 Slots":"5"}');


-- ── Monitor (10) ─────────────────────────────────────────────────────────────
INSERT INTO components (category, name, price, details) VALUES

('Monitor', 'AOC 24G2 24" FHD 144Hz IPS', 14000,
 '{"Size":"24 inch","Resolution":"1920x1080 (FHD)","Panel":"IPS","Refresh Rate":"144Hz","Response Time":"1ms","Brightness":"250 nits","Ports":"HDMI 1.4, DisplayPort 1.2"}'),

('Monitor', 'Samsung Odyssey G4 24" FHD 240Hz', 16000,
 '{"Size":"24 inch","Resolution":"1920x1080 (FHD)","Panel":"IPS","Refresh Rate":"240Hz","Response Time":"1ms","Brightness":"300 nits","Ports":"HDMI 2.0, DisplayPort 1.2"}'),

('Monitor', 'LG 27GN800-B 27" QHD 144Hz Nano IPS', 18000,
 '{"Size":"27 inch","Resolution":"2560x1440 (QHD)","Panel":"Nano IPS","Refresh Rate":"144Hz","Response Time":"1ms","Brightness":"350 nits","Ports":"HDMI 1.4, DisplayPort 1.4 x2"}'),

('Monitor', 'Dell S2722DGM 27" QHD 165Hz VA', 20000,
 '{"Size":"27 inch","Resolution":"2560x1440 (QHD)","Panel":"VA","Refresh Rate":"165Hz","Response Time":"1ms","Brightness":"350 nits","Ports":"HDMI 2.0 x2, DisplayPort 1.4"}'),

('Monitor', 'MSI Optix G274QPX 27" QHD 170Hz', 22000,
 '{"Size":"27 inch","Resolution":"2560x1440 (QHD)","Panel":"IPS","Refresh Rate":"170Hz","Response Time":"1ms","Brightness":"400 nits","Ports":"HDMI 2.0 x2, DisplayPort 1.4 x2"}'),

('Monitor', 'ASUS TUF VG279QM 27" FHD 280Hz', 24000,
 '{"Size":"27 inch","Resolution":"1920x1080 (FHD)","Panel":"IPS","Refresh Rate":"280Hz","Response Time":"1ms","Brightness":"400 nits","Ports":"HDMI 2.0, DisplayPort 1.4 x2"}'),

('Monitor', 'LG 27GP850-B 27" QHD 165Hz Nano IPS', 26000,
 '{"Size":"27 inch","Resolution":"2560x1440 (QHD)","Panel":"Nano IPS","Refresh Rate":"165Hz","Response Time":"1ms","Brightness":"400 nits","Ports":"HDMI 2.0, DisplayPort 1.4 x2"}'),

('Monitor', 'Samsung Odyssey G7 32" QHD 240Hz VA', 32000,
 '{"Size":"32 inch","Resolution":"2560x1440 (QHD)","Panel":"VA","Refresh Rate":"240Hz","Response Time":"1ms","Brightness":"600 nits","Ports":"HDMI 2.1, DisplayPort 1.4 x2"}'),

('Monitor', 'ASUS ROG Swift PG279QM 27" QHD 240Hz', 45000,
 '{"Size":"27 inch","Resolution":"2560x1440 (QHD)","Panel":"IPS","Refresh Rate":"240Hz","Response Time":"1ms","Brightness":"400 nits","Ports":"HDMI 2.0, DisplayPort 1.4 x3"}'),

('Monitor', 'LG 27GR95QE-B 27" QHD 240Hz OLED', 70000,
 '{"Size":"27 inch","Resolution":"2560x1440 (QHD)","Panel":"OLED","Refresh Rate":"240Hz","Response Time":"0.03ms","Brightness":"1000 nits","Ports":"HDMI 2.1 x2, DisplayPort 1.4"}');


-- ── Keyboard (10) ─────────────────────────────────────────────────────────────
INSERT INTO components (category, name, price, details) VALUES

('Keyboard', 'Zebronics Zeb-K21 USB Keyboard', 600,
 '{"Type":"Membrane","Layout":"Full Size","Connection":"USB","Backlight":"No","Switch":"N/A"}'),

('Keyboard', 'Ant Esports MK1300 Pro TKL', 2500,
 '{"Type":"Membrane","Layout":"TKL (87 key)","Connection":"USB","Backlight":"RGB","Switch":"N/A"}'),

('Keyboard', 'Zebronics Zeb-MAX PRO Mechanical', 3000,
 '{"Type":"Mechanical","Layout":"Full Size","Connection":"USB","Backlight":"LED","Switch":"Blue"}'),

('Keyboard', 'Redragon K552 KUMARA TKL', 4500,
 '{"Type":"Mechanical","Layout":"TKL (87 key)","Connection":"USB","Backlight":"RGB","Switch":"Blue"}'),

('Keyboard', 'HyperX Alloy Core RGB', 5000,
 '{"Type":"Membrane","Layout":"Full Size","Connection":"USB","Backlight":"RGB","Switch":"N/A"}'),

('Keyboard', 'Ant Esports MK3400W TKL Wireless', 5500,
 '{"Type":"Mechanical","Layout":"TKL (87 key)","Connection":"USB / 2.4GHz / Bluetooth","Backlight":"RGB","Switch":"Red"}'),

('Keyboard', 'Redragon K530 Pro 75% Wireless', 7000,
 '{"Type":"Mechanical","Layout":"75%","Connection":"USB / Bluetooth","Backlight":"RGB","Switch":"Brown"}'),

('Keyboard', 'Keychron K2 V2 75% Wireless', 9000,
 '{"Type":"Mechanical","Layout":"75%","Connection":"USB-C / Bluetooth","Backlight":"RGB","Switch":"Gateron Red"}'),

('Keyboard', 'Logitech G815 LIGHTSYNC', 14000,
 '{"Type":"Mechanical","Layout":"Full Size","Connection":"USB","Backlight":"RGB","Switch":"GL Linear"}'),

('Keyboard', 'SteelSeries Apex Pro TKL Wireless', 18000,
 '{"Type":"Mechanical","Layout":"TKL (87 key)","Connection":"USB / 2.4GHz","Backlight":"RGB","Switch":"OmniPoint Adjustable"}');


-- ── Mouse (10) ───────────────────────────────────────────────────────────────
INSERT INTO components (category, name, price, details) VALUES

('Mouse', 'Zebronics Zeb-Comfort Wired Mouse', 400,
 '{"DPI":"1200","Sensor":"Optical","Buttons":"3","Connection":"USB Wired","Weight":"75g","RGB":"No"}'),

('Mouse', 'Ant Esports GM60 RGB Gaming Mouse', 1500,
 '{"DPI":"3200","Sensor":"Optical","Buttons":"7","Connection":"USB Wired","Weight":"120g","RGB":"Yes"}'),

('Mouse', 'Logitech G102 LIGHTSYNC', 2000,
 '{"DPI":"200 - 8000","Sensor":"Optical","Buttons":"6","Connection":"USB Wired","Weight":"85g","RGB":"Yes"}'),

('Mouse', 'Redragon M711 COBRA Gaming Mouse', 2500,
 '{"DPI":"500 - 10000","Sensor":"Optical","Buttons":"7","Connection":"USB Wired","Weight":"130g","RGB":"Yes"}'),

('Mouse', 'Razer DeathAdder Essential', 3000,
 '{"DPI":"200 - 6400","Sensor":"5G Optical","Buttons":"5","Connection":"USB Wired","Weight":"96g","RGB":"Yes"}'),

('Mouse', 'HyperX Pulsefire Haste Wired', 5000,
 '{"DPI":"100 - 16000","Sensor":"Optical","Buttons":"6","Connection":"USB Wired","Weight":"59g","RGB":"Yes"}'),

('Mouse', 'SteelSeries Aerox 3 Wireless', 7000,
 '{"DPI":"100 - 18000","Sensor":"TrueMove Air","Buttons":"6","Connection":"USB / 2.4GHz / Bluetooth","Weight":"68g","RGB":"Yes"}'),

('Mouse', 'Logitech G502 X Plus Wireless', 7500,
 '{"DPI":"100 - 25600","Sensor":"HERO 25K","Buttons":"13","Connection":"Wireless 2.4GHz","Weight":"106g","RGB":"Yes"}'),

('Mouse', 'Logitech G Pro X Superlight 2', 12000,
 '{"DPI":"100 - 32000","Sensor":"HERO 2","Buttons":"5","Connection":"Wireless 2.4GHz","Weight":"60g","RGB":"No"}'),

('Mouse', 'Razer Viper V2 Pro', 16000,
 '{"DPI":"100 - 30000","Sensor":"Focus Pro 30K","Buttons":"5","Connection":"Wireless 2.4GHz","Weight":"58g","RGB":"No"}');
