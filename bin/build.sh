#!/bin/bash

clean() {
    rm -rf dist/
}

insert_line() {
    printf "$1\n" >> dist/.htaccess
}

insert_file() {
    cat "$1" >> dist/.htaccess
}

insert_file_comment_out() {
    printf "%s\n" "$(cat "$1" | sed -E 's/^([^#])(.+)$/# \1\2/g')" >> dist/.htaccess
    # sed -E 's/^([\ ]*)([^#]+)$/# \1\2/g'
}

insert_header() {
    local title="$(printf "$1" | tr '[:lower:]' '[:upper:]')"

    insert_line "# ##############################################################################"
    insert_line "# # $title #"
    insert_line "# ##############################################################################"

}

htaccess() {

    insert_line "# Apache Server Configs v2.8.0 | MIT License"
    insert_line "# https://github.com/h5bp/server-configs-apache"
    insert_line
    insert_line "# (!) Using \`.htaccess\` files slows down Apache, therefore, if you have access"
    insert_line "# to the main server config file (usually called \`httpd.conf\`), you should add"
    insert_line "# this logic there: http://httpd.apache.org/docs/current/howto/htaccess.html."
    insert_line

    insert_header "cross-origin resource sharing (cors)"
    insert_line
    insert_file "src/cors/cross_origin_requests.conf"
    insert_line
    insert_file_comment_out "src/cors/cross_origin_resource_timing.conf"
    insert_line
    insert_file "src/cors/cors_enabled_images.conf"
    insert_line
    insert_line

    insert_header "errors"
    insert_line
    insert_file "src/errors/error_prevention.conf"
    insert_line
    insert_file_comment_out "src/errors/custom_error.conf"
    insert_line
    insert_line

    insert_header "internet explorer"
    insert_line
    insert_file "src/internet_explorer/x-ua-compatible.conf"
    insert_line
    insert_file_comment_out "src/internet_explorer/iframes_cookies.conf"
    insert_line
    insert_line

    insert_header "media types and character encodings"
    insert_line
    insert_file "src/media_types_and_character_encodings/media_types.conf"
    insert_line
    insert_file "src/media_types_and_character_encodings/character_encodings.conf"
    insert_line
    insert_line

    insert_header "url rewrites"
    insert_line
    insert_file "src/url_rewrites/a.conf"
    insert_line
    insert_line

    insert_header "security"
    insert_line
    insert_file_comment_out "src/security/clickjacking.conf"
    insert_line
    insert_file_comment_out "src/security/csp.conf"
    insert_line
    insert_file "src/security/file_access.conf"
    insert_line
    insert_file "src/security/x-content-type-options.conf"
    insert_line
    insert_file_comment_out "src/security/reflected_cross_site_scripting.conf"
    insert_line
    insert_file_comment_out "src/security/ssl.conf"
    insert_line
    insert_file_comment_out "src/security/hsts.conf"
    insert_line
    insert_file_comment_out "src/security/server_information.conf"
    insert_line
    insert_line

    insert_header "web performance"
    insert_line
    insert_file "src/web_performance/compression.conf"
    insert_line
    insert_file_comment_out "src/web_performance/content_transformation.conf"
    insert_line
    insert_file "src/web_performance/etags.conf"
    insert_line
    insert_file "src/web_performance/expires_headers.conf"
    insert_line
    insert_file_comment_out "src/web_performance/cache_busting.conf"
    insert_line
    insert_file_comment_out "src/web_performance/file_concatenation.conf"

}

conf() {
    mkdir dist/h5bp-configs
    cp -r src/ dist/h5bp-configs/
}

main() {

    cd "${BASH_SOURCE%/*}" && cd ..
    clean
    mkdir dist/

    htaccess
    conf
}

main
