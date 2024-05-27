#!/bin/bash

FLUTTER_VERSION="3.22.1"

if cd flutter; then git pull && cd .. ; else git clone -b $FLUTTER_VERSION https://github.com/flutter/flutter.git; fi && ls && flutter/bin/flutter doctor && flutter/bin/flutter clean && flutter/bin/flutter config --enable-web

#flutter/bin/flutter pub get

flutter/bin/flutter gen-l10n

#flutter/bin/flutter build web --release --web-renderer html