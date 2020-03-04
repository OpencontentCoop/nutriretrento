{def $is_area_tematica = is_area_tematica()}
{def $footerBlocks = 4
     $has_notes = false()
     $has_contacts = false()
     $has_links  = false()
     $has_social  = false()
     $footerBlocksClass = 'u-sizeFull'}

{if and($is_area_tematica, $is_area_tematica|has_attribute('link'))}
    {def $footer_links = array()}
    {foreach $is_area_tematica|attribute('link').content.relation_list as $item}
        {set $footer_links = $footer_links|append(fetch(content, node, hash(node_id, $item.node_id)))}
    {/foreach}
{else}
    {def $footer_links = fetch( 'openpa', 'footer_links' )}
{/if}

{if and($is_area_tematica, $is_area_tematica|has_attribute('note_footer'))}
    {def $footer_notes = $is_area_tematica|attribute('note_footer')}
{else}
    {def $footer_notes = fetch( 'openpa', 'footer_notes' )}
{/if}

{if count( $footer_notes )|gt(0)}
    {set $has_notes = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if and($is_area_tematica, $is_area_tematica|has_attribute('contacts'))}
    {def $contacts = parse_contacts_matrix($is_area_tematica)}
{else}
    {def $contacts = $pagedata.contacts}
{/if}

{if or(is_set($contacts.indirizzo), is_set($contacts.telefono), is_set($contacts.fax),
       is_set($contacts.email), is_set($contacts.pec), is_set($contacts.web))}
    {set $has_contacts = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if or(is_set($contacts.facebook), is_set($contacts.twitter), is_set($contacts.linkedin), is_set($contacts.instagram))}
    {set $has_social = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if count( $footer_links )|gt(0)}
    {set $has_links = true()}
{else}
    {set $footerBlocks = $footerBlocks|sub(1)}
{/if}

{if $footerBlocks|gt(1)}
    {set $footerBlocksClass = concat('u-md-size1of', $footerBlocks, ' u-lg-size1of', $footerBlocks) }
{/if}

<div class="footer-container u-hiddenPrint">
  <div class="u-layout-wide u-layoutCenter u-layout-r-withGutter">
    <footer class="Footer u-hiddenPrint">
        {*<div class="u-cf">
            {if and( is_set($pagedata.header.logo.url), $pagedata.header.logo.url)}
                <img height="75" class="Footer-logo"
                     src="{$pagedata.header.logo.url|ezroot(no)}"
                     alt="{ezini('SiteSettings','SiteName')}"/>
            {/if}
            {if or($pagedata.homepage|has_attribute('only_logo')|not(), and( $pagedata.homepage|has_attribute('only_logo'), $pagedata.homepage|attribute('only_logo').data_int|eq(0) ))}
                <p class="Footer-siteName">{ezini('SiteSettings','SiteName')}</p>
            {/if}
        </div>*}

        <div class="Grid Grid--withGutter">

            {if $has_notes}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Informations'|i18n('openpa/footer')}</h2>
                    <div class="Footer-subBlock">
                        <div class="u-lineHeight-xl u-color-white">
                            {attribute_view_gui attribute=$footer_notes}
                        </div>
                    </div>
                </div>
            {/if}

            {if $has_contacts}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Contacts'|i18n('openpa/footer')}</h2>
                    {include uri='design:footer/contacts_list.tpl' contacts=$contacts}
                </div>
            {/if}

            {if $has_links}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Links'|i18n('openpa/footer')}</h2>
                    <ul>
                        {foreach $footer_links as $item}
                            {def $href = $item.url_alias|ezurl(no)}
                            {if eq( $ui_context, 'browse' )}
                                {set $href = concat("content/browse/", $item.node_id)|ezurl(no)}
                            {elseif $pagedata.is_edit}
                                {set $href = '#'}
                            {elseif and( is_set( $item.data_map.location ), $item.data_map.location.has_content )}
                                {set $href = $item.data_map.location.content}
                            {/if}
                            <li><a href="{$href}"
                                   title="{'Read more'|i18n('openpa/widget')} {$item.name|wash()}">{$item.name|wash()}</a>
                            </li>
                            {undef $href}
                        {/foreach}
                    </ul>
                </div>
            {/if}

            {if $has_social}
                <div class="Footer-block Grid-cell {$footerBlocksClass}">
                    <h2 class="Footer-blockTitle">{'Follow us'|i18n('openpa/footer')}</h2>
                    {include uri='design:footer/social.tpl'}
                </div>
            {/if}

        </div>

        <div class="Footer-links u-cf"></div>

        <div class="Grid Grid--withGutter">
            <div class="Footer-block Grid-cell u-md-size3of5 u-lg-size3of5">
                {include uri='design:footer/copyright.tpl'}
            </div>
            <div class="Footer-block Grid-cell u-md-size2of5 u-lg-size2of5 text-right">
                {if $pagedata.is_login_page|not()}
                    {include uri='design:footer/user_access.tpl'}
                {/if}
            </div>
        </div>
    </footer>
  </div>
</div>

<a href="#" title="torna all'inizio del contenuto" class="ScrollTop js-scrollTop js-scrollTo">
    <i class="ScrollTop-icon Icon-collapse" aria-hidden="true"></i>
    <span class="u-hiddenVisually">{"back to top"|i18n('openpa/footer')}</span>
</a>

{undef}
