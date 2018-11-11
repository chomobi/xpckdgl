{
xpckdgl
Copyright © 2018 terqüéz <gz0@ro.ru>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}
{$mode objfpc}
{$H+}
{define mydebug}
uses
	{$ifndef windows}
	cwstring,
	{$endif}
	lazutf8,
	x, xlib, xutil, ctypes, strings, sysutils, unix, strutils, baseunix;
type
	TAKMap = Array [0 .. 5] of string;
	TKMap = Array [0 .. 65] of TAKMap;
const
KMap: TKMap = (
('0x06e1', 'Cyrillic_A', 'U+0410', '0xc0', '0x41', '0x41'),
('0x06c1', 'Cyrillic_a', 'U+0430', '0xe0', '0x61', '0x61'),
('0x06e2', 'Cyrillic_BE', 'U+0411', '0xc1', '0x80', '0x5e'),
('0x06c2', 'Cyrillic_be', 'U+0431', '0xe1', '0xa0', '0xa0'),
('0x06f7', 'Cyrillic_VE', 'U+0412', '0xc2', '0x42', '0x42'),
('0x06d7', 'Cyrillic_ve', 'U+0432', '0xe2', '0xa2', '0xa2'),
('0x06e7', 'Cyrillic_GHE', 'U+0413', '0xc3', '0x82', '0x82'),
('0x06c7', 'Cyrillic_ghe', 'U+0433', '0xe3', '0xa5', '0xa5'),
('0x06e4', 'Cyrillic_DE', 'U+0414', '0xc4', '0x83', '0x83'),
('0x06c4', 'Cyrillic_de', 'U+0434', '0xe4', '0xa6', '0xa6'),
('0x06e5', 'Cyrillic_IE', 'U+0415', '0xc5', '0x45', '0x45'),
('0x06c5', 'Cyrillic_ie', 'U+0435', '0xe5', '0x65', '0x65'),
('0x06b3', 'Cyrillic_IO', 'U+0401', '0xa8', '0xcb', '0xcb'),
('0x06a3', 'Cyrillic_io', 'U+0451', '0xb8', '0xeb', '0xeb'),
('0x06f6', 'Cyrillic_ZHE', 'U+0416', '0xc6', '0x84', '0x84'),
('0x06d6', 'Cyrillic_zhe', 'U+0436', '0xe6', '0xa8', '0xa8'),
('0x06fa', 'Cyrillic_ZE', 'U+0417', '0xc7', '0x85', '0x85'),
('0x06da', 'Cyrillic_ze', 'U+0437', '0xe7', '0xa9', '0xa9'),
('0x06e9', 'Cyrillic_I', 'U+0418', '0xc8', '0x86', '0x86'),
('0x06c9', 'Cyrillic_i', 'U+0438', '0xe8', '0xaa', '0xaa'),
('0x06ea', 'Cyrillic_SHORTI', 'U+0419', '0xc9', '0x87', '0x87'),
('0x06ca', 'Cyrillic_shorti', 'U+0439', '0xe9', '0xab', '0xab'),
('0x06eb', 'Cyrillic_KA', 'U+041A', '0xca', '0x4b', '0x4b'),
('0x06cb', 'Cyrillic_ka', 'U+043A', '0xea', '0xac', '0xac'),
('0x06ec', 'Cyrillic_EL', 'U+041B', '0xcb', '0x88', '0x88'),
('0x06cc', 'Cyrillic_el', 'U+043B', '0xeb', '0xae', '0xae'),
('0x06ed', 'Cyrillic_EM', 'U+041C', '0xcc', '0x4d', '0c4d'),
('0x06cd', 'Cyrillic_em', 'U+043C', '0xec', '0xaf', '0xaf'),
('0x06ee', 'Cyrillic_EN', 'U+041D', '0xcd', '0x48', '0x48'),
('0x06ce', 'Cyrillic_en', 'U+043D', '0xed', '0xb0', '0xb0'),
('0x06ef', 'Cyrillic_O', 'U+041E', '0xce', '0x4f', '0x4f'),
('0x06cf', 'Cyrillic_o', 'U+043E', '0xee', '0x6f', '0x6f'),
('0x06f0', 'Cyrillic_PE', 'U+041F', '0xcf', '0x89', '0x89'),
('0x06d0', 'Cyrillic_pe', 'U+043F', '0xef', '0xb1', '0xb1'),
('0x06f2', 'Cyrillic_ER', 'U+0420', '0xd0', '0x50', '0x50'),
('0x06d2', 'Cyrillic_er', 'U+0440', '0xf0', '0x70', '0x70'),
('0x06f3', 'Cyrillic_ES', 'U+0421', '0xd1', '0x43', '0x43'),
('0x06d3', 'Cyrillic_es', 'U+0441', '0xf1', '0x63', '0x63'),
('0x06f4', 'Cyrillic_TE', 'U+0422', '0xd2', '0x54', '0x54'),
('0x06d4', 'Cyrillic_te', 'U+0442', '0xf2', '0xb2', '0xb2'),
('0x06f5', 'Cyrillic_U', 'U+0423', '0xd3', '0x8b', '0x8b'),
('0x06d5', 'Cyrillic_u', 'U+0443', '0xf3', '0xb3', '0xb3'),
('0x06e6', 'Cyrillic_EF', 'U+0424', '0xd4', '0x91', '0x91'),
('0x06c6', 'Cyrillic_ef', 'U+0444', '0xf4', '0xb4', '0xb4'),
('0x06e8', 'Cyrillic_HA', 'U+0425', '0xd5', '0x58', '0x58'),
('0x06c8', 'Cyrillic_ha', 'U+0445', '0xf5', '0x78', '0x78'),
('0x06e3', 'Cyrillic_TSE', 'U+0426', '0xd6', '0x92', '0x92'),
('0x06c3', 'Cyrillic_tse', 'U+0446', '0xf6', '0xb5', '0xb5'),
('0x06fe', 'Cyrillic_CHE', 'U+0427', '0xd7', '0x93', '0x93'),
('0x06de', 'Cyrillic_che', 'U+0447', '0xf7', '0xb6', '0xb6'),
('0x06fb', 'Cyrillic_SHA', 'U+0428', '0xd8', '0x94', '0x94'),
('0x06db', 'Cyrillic_sha', 'U+0448', '0xf8', '0xb7', '0xb7'),
('0x06fd', 'Cyrillic_SHCHA', 'U+0429', '0xd9', '0x95', '0x95'),
('0x06dd', 'Cyrillic_shcha', 'U+0449', '0xf9', '0xb8', '0xb8'),
('0x06ff', 'Cyrillic_HARDSIGN', 'U+042A', '0xda', '0x96', '0x96'),
('0x06df', 'Cyrillic_hardsign', 'U+044A', '0xfa', '0xb9', '0xb9'),
('0x06f9', 'Cyrillic_YERU', 'U+042B', '0xdb', '0x97', '0x97'),
('0x06d9', 'Cyrillic_yeru', 'U+044B', '0xfb', '0xba', '0xba'),
('0x06f8', 'Cyrillic_SOFTSIGN', 'U+042C', '0xdc', '0x98', '0x98'),
('0x06d8', 'Cyrillic_softsign', 'U+044C', '0xfc', '0xbb', '0xbb'),
('0x06fc', 'Cyrillic_E', 'U+042D', '0xdd', '0x99', '0x99'),
('0x06dc', 'Cyrillic_e', 'U+044D', '0xfd', '0xbc', '0xbc'),
('0x06e0', 'Cyrillic_YU', 'U+042E', '0xde', '0x9b', '0x9b'),
('0x06c0', 'Cyrillic_yu', 'U+044E', '0xfe', '0xbe', '0xbe'),
('0x06f1', 'Cyrillic_YA', 'U+042F', '0xdf', '0xd7', '0xd7'),
('0x06d1', 'Cyrillic_ya', 'U+044F', '0xff', '0xf7', '0xf7')
);
VERSION = '0.1.0';
var
	display: PDisplay;
	eu4_window: TWindow;
	event: TXEvent;
	focus_return: TWindow;
	revert_to_return: cint;
	f1, f2: Text;
	str: string;
	i: byte;
	s_default_layout: string;
	s_spec_layout: string;
	s_environment_display: string;
	OldAction, NewAction: SigActionRec;
//	xerrorhandler: TXErrorHandler;
	enc: byte;
function lookup_window(root: TWindow): smallint;
var
	root_return: TWindow;
	parent_return: TWindow;
	children_return: PWindow;
	nchildren_return, i: cuint;
	status: TStatus;
{$ifdef mydebug}
	text_prop_return: TXTextProperty;
	list_return: PPchar;
	count_return, j: cint;
	cint_status: cint;
{$endif}
	class_hint: PXClassHint;
begin
	if eu4_window <> 0 then exit(0);
	class_hint := XAllocClassHint;
	status := XQueryTree(display, root, @root_return, @parent_return, @children_return, @nchildren_return);
	if status = 0 then
	begin
		writeln('Не получается опросить дерево!');
		XFree(class_hint);
		exit(1);
	end;
	if nchildren_return > 0 then
	begin
		for i := 0 to nchildren_return - 1 do
		begin
			if eu4_window <> 0 then break;
{$ifdef mydebug}
			writeln(IntToHex(children_return[i], 0));
			//Заголовок
			status := XGetWMName(display, children_return[i], @text_prop_return);
			if status = 0 then writeln('Не получается запросить WM_NAME!')
			else
			begin
				cint_status := Xutf8TextPropertyToTextList(display, @text_prop_return, @list_return, @count_return);
				if cint_status <> 0 then writeln('Не получается сконвертировать текст!')
				else
				begin
					writeln(count_return);
					for j := 0 to count_return - 1 do writeln(list_return[j]);
				end;
			end;
			//Конец заголовка
{$endif}
			//Класс
			status := XGetClassHint(display, children_return[i], class_hint);
			if status = 0 then {$ifdef mydebug}writeln('Не получается запросить WM_CLASS!'){$endif}
			else
			begin
				{$ifdef mydebug}writeln(class_hint^.res_class);{$endif}
				if (pos('eu4', class_hint^.res_class) <> 0) or (pos('ck2', class_hint^.res_class) <> 0) then
				begin
					eu4_window := children_return[i];
					writeln('Окно найдено.');
				end;
			end;
			//Конец класса
			if eu4_window = 0 then lookup_window := lookup_window(children_return[i])
			else
			begin
				lookup_window := 0;
				eu4_window := children_return[i];
				break;
			end;
		end;
	end;
	XFree(children_return);
	XFree(class_hint);
end;
function fXErrorHandler(para1: PDisplay; para2: PXErrorEvent): cint; cdecl;
begin
	writeln('Игнорирование ошибки.');
	fXErrorHandler := 0;
end;
procedure SignalHandler(sig: LongInt); cdecl;
begin
	fpsystem('xkbcomp -w 0 ' + s_default_layout + ' ' + s_environment_display);
	erase(f1);
	erase(f2);
	XCloseDisplay(display);
	writeln;
	halt(0);
end;
begin
	writeln('xpckdgl ' + VERSION);
	writeln('Copyright (C) 2018 terqüéz <gz0@ro.ru>');
	writeln('License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.');
	writeln('This is free software: you are free to change and redistribute it.');
	writeln('There is NO WARRANTY, to the extent permitted by law.');
	if ParamCount = 0 then
	begin
		writeln('Кодировка не указана - выбрана CP1252B.');
		enc := 4;
	end
	else
	begin
		case ParamStr(1) of
		'cp1252a':
			begin
				writeln('Кодировка выбрана: CP1252A.');
				enc := 3;
			end;
		'cp1252b':
			begin
				writeln('Кодировка выбрана: CP1252B.');
				enc := 4;
			end;
		'cp1252c':
			begin
				writeln('Кодировка выбрана: CP1252C.');
				enc := 5;
			end;
		else
		begin
			writeln('Была задана неизвестная кодировка. Сброс на CP1252B.');
			enc := 4;
		end;
		end;
	end;
//	XErrorHandler := @fXErrorHandler;
	XSetErrorHandler(@fXErrorHandler);
	s_default_layout := '/tmp/' + IntToStr(GetProcessID) + 'default.xkb';
	s_spec_layout := '/tmp/' + IntToStr(GetProcessID) + 'spec.xkb';
	s_environment_display := GetEnvironmentVariable('DISPLAY');
	if length(s_environment_display) = 0 then s_environment_display := ':0.0';
	display := XOpenDisplay(PChar(s_environment_display));
	if display = nil then
	begin
		writeln('Не получается создать соединение с сервером!');
		halt(1);
	end;
//	eu4_window := 0;
//	lookup_window(XDefaultRootWindow(display));
//	XSelectInput(display, eu4_window, FocusChangeMask or StructureNotifyMask);
//	error_handler := XSetErrorHandler(ErrorHandler);
	fpsystem('xkbcomp -w 0 -xkb ' + s_environment_display + ' ' + s_default_layout);
	AssignFile(f1, s_default_layout);
	AssignFile(f2, s_spec_layout);
	reset(f1);
	rewrite(f2);
	while not eof(f1) do
	begin
		readln(f1, str);
		for i := 0 to 65 do
		begin
			str := AnsiReplaceStr(str, KMap[i][0] + ',', KMap[i][enc] + ',');
			str := AnsiReplaceStr(str, KMap[i][0] + ' ', KMap[i][enc] + ' ');
			str := AnsiReplaceStr(str, KMap[i][1] + ',', KMap[i][enc] + ',');
			str := AnsiReplaceStr(str, KMap[i][1] + ' ', KMap[i][enc] + ' ');
			str := AnsiReplaceStr(str, KMap[i][2] + ',', KMap[i][enc] + ',');
			str := AnsiReplaceStr(str, KMap[i][2] + ' ', KMap[i][enc] + ' ');
		end;
		writeln(f2, str);
	end;
	CloseFile(f1);
	CloseFile(f2);
	NewAction.sa_Handler := SigActionHandler(@SignalHandler);
	fillchar(NewAction.sa_Mask, sizeof(NewAction.sa_Mask), #0);
	NewAction.sa_Flags := 0;
	if fpSigAction(SigInt, @NewAction, @OldAction) <> 0 then halt(1);
	if fpSigAction(SigTerm, @NewAction, @OldAction) <> 0 then halt(1);
	while true do
	begin
		eu4_window := 0;
		lookup_window(XDefaultRootWindow(display));
		while eu4_window = 0 do
		begin
			Sleep(2000);
			lookup_window(XDefaultRootWindow(display));
		end;
		write('Оформление подписки на события ... ');
		XSelectInput(display, eu4_window, FocusChangeMask or StructureNotifyMask);
		writeln('готово.');
		XGetInputFocus(display, @focus_return, @revert_to_return);
		if eu4_window = focus_return then
		begin
			writeln('Фокус в окне.');
			fpsystem('xkbcomp -w 0 ' + s_spec_layout + ' ' + s_environment_display);
		end
		else writeln('Фокус вне окна.');
		while true do
		begin
			XNextEvent(display, @event);
			case event._type of
				FocusIn:
					begin
						writeln('Вход фокуса.'); //spec
						fpsystem('xkbcomp -w 0 ' + s_spec_layout + ' ' + s_environment_display);
					end;
				FocusOut:
					begin
						writeln('Выход фокуса'); //def
						fpsystem('xkbcomp -w 0 ' + s_default_layout + ' ' + s_environment_display);
					end;
				DestroyNotify:
					begin
						writeln('Окно уничтожено.'); //def
						fpsystem('xkbcomp -w 0 ' + s_default_layout + ' ' + s_environment_display);
						break;
					end;
			end;
		end;
		writeln('Выход из цикла обработки событий.');
	end;
	erase(f1);
	erase(f2);
	XCloseDisplay(display);
end.
