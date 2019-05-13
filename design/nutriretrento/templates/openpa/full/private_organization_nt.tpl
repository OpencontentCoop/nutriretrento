{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}


<div class="openpa-full class-{$node.class_identifier}">
    <div class="title">
        {include uri='design:openpa/full/parts/node_languages.tpl'}
        <h2>{$node.name|wash()}</h2>
    </div>
    <div class="content-container">
        <div class="content withExtra">

            <article class="content-main-abstract">                
                {attribute_view_gui attribute=$node.data_map.abstract} 
                {include uri='design:atoms/image.tpl' item=$node image_class=imagefull css_classes="main_image" image_css_class="img-responsive"}
            </article>

            <article class="content-main-body">
                {attribute_view_gui attribute=$node.data_map.descrizione_completa} 
            </article>

            <div class="content-detail u-layout-prose">                
                {if or($node.data_map.certificazioni.has_content,$node.data_map.altre_certificazioni.has_content)}
                <div class="content-detail-item">
                    <div class="value">                    
                        <div class="u-text-h5">
                            <strong>{$node.data_map.certificazioni.contentclass_attribute_name}</strong>
                        </div>        
                        <div class="Prose">
                            {attribute_view_gui attribute=$node.data_map.certificazioni}
                            {attribute_view_gui attribute=$node.data_map.altre_certificazioni}
                        </div>
                    </div>
                </div>
                {/if}

                {if $node.data_map.produttore_punto_vendita_trento.data_int}
                <div class="content-detail-item">
                    <div class="value">                    
                        <div class="u-text-h6">
                            <strong>{$node.data_map.produttore_punto_vendita_trento.contentclass_attribute_name}</strong>
                        </div>        
                        <div class="Prose">                            
                            {attribute_view_gui attribute=$node.data_map.produttore_info_punto_vendita_trento}
                        </div>
                    </div>
                </div>
                {/if}

                {if $node.data_map.produttore_vende_presso_sede.data_int}
                <div class="content-detail-item">
                    <div class="value">                    
                        <div class="u-text-h6">
                            <strong>{$node.data_map.produttore_vende_presso_sede.contentclass_attribute_name}</strong>
                        </div>        
                        <div class="Prose">                            
                            {attribute_view_gui attribute=$node.data_map.produttore_orari}
                        </div>
                    </div>
                </div>
                {/if}

                {if $node.data_map.produttore_visite.data_int}
                <div class="content-detail-item">
                    <div class="value">                    
                        <div class="u-text-h6">
                            <strong>L’azienda è disponibile a visite da parte dei consumatori</strong>
                        </div>                                
                    </div>
                </div>
                {/if}

                {if $node.data_map.produttore_negozi.has_content}
                <div class="content-detail-item">
                    <div class="value">                    
                        <div class="u-text-h5">
                            <strong>Negozi di riferimento a Trento</strong>
                        </div>        
                        <div class="Prose">                            
                            {attribute_view_gui attribute=$node.data_map.produttore_negozi}
                        </div>
                    </div>
                </div>
                {/if}

                {if $node.data_map.produttore_prodotti.has_content}
                <div class="content-detail-item">
                    <div class="value">                    
                        <p class="u-text-h5">
                            <strong>{$node.data_map.produttore_prodotti.contentclass_attribute_name}</strong>
                        </p>        
                        <div class="Prose">             
                            {def $product_groups = nutriretrento_product_tree($node.object)}                            
                            {foreach $product_groups as $type => $list}
                            <p>
                            <strong>{$type|wash()}</strong><br />
                            {foreach $list as $name => $item}
                                <a href="{$item.main_node.url_alias|ezurl(no)}">{$name|wash()}</a>{delimiter}, {/delimiter}
                            {/foreach}
                            </p>
                            {/foreach}
                        </div>
                    </div>
                </div>
                {/if}

                
            </div>

            

            {node_view_gui content_node=$node view=children view_parameters=$view_parameters}

        </div>

        <div class="extra">
            
            {if $openpa.content_contacts.has_content}
                <div class="openpa-widget">
                    <h3 class="openpa-widget-title"><span>Contatti</span></h3>
                    <div class="Grid Grid--withGutter">
                        {foreach $openpa.content_contacts.attributes as $openpa_attribute}
                            {def $size = 12}
                            {if $openpa_attribute.full.show_label}
                                <div class="Grid-cell u-sm-size3of12 u-md-size3of12 u-lg-size3of12 u-margin-bottom-l">
                                    <strong>{$openpa_attribute.label}: </strong>
                                </div>
                            {/if}
                            {if $openpa_attribute.full.show_label}
                                {set $size = 9}
                            {/if}
                            <div class="Grid-cell u-sm-size{$size}of12 u-md-size{$size}of12 u-lg-size{$size}of12 u-margin-bottom-l">
                                {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.full.show_link|not, 'no-link', '')}
                            </div>
                            {undef $size}
                        {/foreach}
                    </div>                    
                </div>
            {/if}

            {if ezini('GeneralSettings','SocialButtons', 'openpa.ini')|eq('enabled')}
              {include uri='design:openpa/full/parts/social_buttons.tpl'}
            {/if}

            {include uri='design:openpa/full/parts/back_to_main_content.tpl'}
          </div>          
    </div>
    {if $openpa.content_date.show_date}
        {include uri=$openpa.content_date.template}
    {/if}
</div>


{ezpagedata_set('has_sidemenu', true())}