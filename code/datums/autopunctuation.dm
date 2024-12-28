// Проверяет, заканчивается ли строка на букву (латиница или кириллица), цифру или на последовательность в формате чата (+, _, и т.д.) без точки.
GLOBAL_DATUM_INIT(needs_eol_autopunctuation, /regex, regex(@"([a-zA-Z\dа-яА-ЯёЁ]|[^.?!~-][+|_])$"))

// Все некапитализированные 'и', окруженные пробелами (например, 'привет >и< я кот')
GLOBAL_DATUM_INIT(noncapital_i, /regex, regex(@"\b[и]\b", "g"))

/// Обеспечивает, чтобы предложения заканчивались соответствующим знаком препинания (точка, если нет) и чтобы все 'и' с пробелами были заглавными.
/// Если предложение заканчивается на чатовое форматирование для выделения, курсивов или подчеркиваний и не имеет предшествующей точки, восклицательного знака или другого терминатора предложения, добавьте точку.
/// (например: 'Борги - это рога' становится 'Борги - это рога.', '+БОРГИ - ЭТО РОГА+' становится '+БОРГИ - ЭТО РОГА+.', '+Борги - это рога~+' остается без изменений.)
/proc/autopunct_bare(input_text)
    if (findtext(input_text, GLOB.needs_eol_autopunctuation))
        input_text += "."

    input_text = replacetext(input_text, GLOB.noncapital_i, "И")
    return input_text
