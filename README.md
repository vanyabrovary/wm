## Авторизация посредством Apache (mod_auth_form)

Модуль mod_auth_form позволяет использовать HTML форму входа для ограничения доступа путем поиска пользователей в БД (mod_dbd, mod_authn_dbd)

Если пользователь не авторизирован, открывается форма авторизации, если авторизирован, то запрос переходит в обработчик.

После успешной авторизации в обработчике становится доступной переменная $ENV{'REMOTE_USER'}, которая содержит идентификатор обозначающий пользователя.

### Используются модули:

mod_auth_form - позволяет использовать HTML форму входа.

mod_dbd       - для подключения к БД из apache. Доступна поддержка популярных СУБД.

mod_authn_dbd - для выполнения аутентификации пользователя в БД из apache.

mod_session   - для сессий и cookies.

### Преимущества:

Запрос проходит несколько фаз при обработке вебсервером. Грубо говоря, сначала идёт фаза подключения, затем фаза обработка запроса, затем фаза формирования ответа, затем фаза отправки ответа. Для выполнения каждой фазы требуется время и ресурсы.

Например простое ограничение доступа по IP. Есть фаза на которой уже известен IP адресс клиента, и если IP запрещён, то можно не преходить к фазе обработки тела запроса.

Аналогично и с авторизацией. Можно выполнить проверку пользователя и запретить доступ еще до того, как выполнение дойдёт до условного index.php.

Также, все указанные выше модули напсаны на С, плюс гибко и просто настраивается пул подключений к локальной или удалённой БД.

Вероятно, что авторизация на C от Apache лучше авторизаций "встроенных" в некоторые скриптовые фреймворки.

### Ссылка на модуль:

https://httpd.apache.org/docs/2.4/mod/mod_auth_form.html

### Дополнительно

https://perl.apache.org/docs/2.0/user/handlers/protocols.html
