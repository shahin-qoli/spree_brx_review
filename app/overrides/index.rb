Deface::Override.new(
    :virtual_path => "spree/layouts/admin",
    :name => "admin_content_admin_tab_parser",
    :insert_bottom => "[data-hook='admin_tabs']",
    :text => "<%= tab :reviews,  :url => 'admin/reviews', :icon => 'icon-th-large' %>",
    :disabled => false
)