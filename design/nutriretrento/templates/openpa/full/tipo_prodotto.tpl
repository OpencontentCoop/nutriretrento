{if $openpa.control_cache.no_cache}
    {set-block scope=root variable=cache_ttl}0{/set-block}
{/if}

{if $openpa.content_tools.editor_tools}
    {include uri=$openpa.content_tools.template}
{/if}

{def $show_left = false()}

<div class="openpa-full class-{$node.class_identifier}">
    <div class="title">
        {include uri='design:openpa/full/parts/node_languages.tpl'}
        <h2>{$node.name|wash()}</h2>
    </div>
    <div class="content-container">
        <div class="content">

            {include uri=$openpa.content_main.template}
            
            {include uri=$openpa.content_detail.template}

            {include uri=$openpa.content_infocollection.template}


            {def $produttore_prodotti=fetch( 'content', 'reverse_related_objects', 
                          hash( 'object_id',$node.object.id, 
                                'sort_by',  array( 'name', true() ),
                                'ignore_visibility', false(),
                                'attribute_identifier', 'private_organization_nt/produttore_prodotti' ) )}

            {def $negozio_prodotti=fetch( 'content', 'reverse_related_objects', 
                          hash( 'object_id',$node.object.id, 
                                'sort_by',  array( 'name', true() ),
                                'ignore_visibility', false(),
                                'attribute_identifier', 'private_organization_nt/negozio_prodotti' ) )}

            {if $produttore_prodotti|count()}
            <div class="content-view-children">            
            <h3 class="u-text-h3">Produttori {if $negozio_prodotti|count()} - <a href="#negozi">Negozi</a>{/if}</h3>
            {foreach $produttore_prodotti as $object}
                {node_view_gui content_node=$object.main_node view=line}
            {/foreach}
            </div>
            {/if}
            
            {if $negozio_prodotti|count()}
            <div class="content-view-children">            
            <h3 class="u-text-h3" id="negozi">Negozi</h3>
            {foreach $negozio_prodotti as $object}
                {node_view_gui content_node=$object.main_node view=line}
            {/foreach}
            </div>
            {/if}

        </div>
        
    </div>
    {if $openpa.content_date.show_date}
        {include uri=$openpa.content_date.template}
    {/if}
</div>



