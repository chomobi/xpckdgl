## Введение
Для ввода текста в EU4 и CK2 нужно передавать коды символов в соответствии с кодировкой, применяемой для вывода текста. Запускаются они в локали «C» (кодировка ISO-8859-1, что не соответствует кодировке, применякмой внутри движка для обработки текста), методы ввода не поддерживают, также у пользователей могут быть свои собственнве раскладки клавиатуры, поэтому единственным средством обеспечить ввод кириллицы с клавиатуры под Linux с X11 в кодировках CP1252{A,B,C} остаётся строить раскладку из текущей на месте, загружая сгенерированную раскладку при переходе в окно EU4 или CK2, и загружая раскладку пользователя при выходе из их окон, для чего и была написана данная утилита.

## Установка

### Инструкции для Debian и основанных на нём дистрибутивов.

Зависимости для сборки:

```
apt-get install fp-compiler fp-units-base fp-units-rtl lcl make
```

Сборка:

Выполнить в каталоге с проектом: `make`. Возможно, придётся исправлять первую строку в Makefile.

Зависимости для выполнения:

```
apt-get install libx11-6 libc6 libxcb1 libxau6 libxdmcp6 libbsd0 x11-xkb-utils
```

## Использование

### Параметры

Параметр №1:

`cp1252a` — формировать раскладку клавиатуры для ввода в окна EU4 и CK2 в кодировке Full-русификатора.

`cp1252b` — то же в кодировке Lite-русификатора EU4.

`cp1252c` — то же в кодировке Lite-русификатора CK2.

### Примечания

После запуска программы на выполнение извлекается пользовательская раскладка клавиатуры и на её основе формируется раскладка для ввода в выбранной пользователем кодировке. Поэтому перед изменением (не переключением) раскладки утилиту следует завершать. Файлы, скармливаемые `xkbcomp(1)`, можно найти в каталоге `/tmp` с именами `${PID}default.xkb` и `${PID}spec.xkb`.

Программу можно запускать независимо от запуска EU4 и CK2 — поиск окон происходит с периодичностью в 2 секунды.

Одновременный запуск CK2 и EU4 не поддерживается — используется первое найденное.

Чтобы завершить программу, пошлите ей `SIGINT` или `SIGTERM`.

## Лицензия

Copyright © 2018 terqüéz

Этот текст доступен на условиях лицензии [CC BY-NC-ND 4.0 Международная](https://creativecommons.org/licenses/by-nc-nd/4.0/). Программный код xpckdgl доступен на условиях GPLv3 или (по вашему выбору) более поздней версии.
