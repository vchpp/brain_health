CI_LOCALE = {
  "vi-us"  => "vi",
  "hm-us" => "hm",
  "zh-us" => "zh_TW",
  "ko-us" => "ko",
  "en-us" => "en"
}

HW_LOCALE = {
  "vi"  => "vi-us",
  "hm" => "hm-us",
  "zh_TW" => "zh-us",
  "zh_CN" => "zh-us",
  "ko" => "ko-us",
  "en" => "en-us"
}

LOCALES = Regexp.union(
  /en-us/i,
  /zh-us/i,
  /vi-us/i,
  /hm-us/i,
  /ko-us/i,
)

VERBOSE_LOCALES = {
  "vi-us"  => "Tiếng Việt",
  "hm-us" => "lus hmoob",
  "zh-us" => "简体中文",
  "ko-us" => "한국어",
  "en-us" => "English"
}
