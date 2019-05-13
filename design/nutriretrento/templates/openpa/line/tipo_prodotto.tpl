{set_defaults(hash('image_class', 'medium'))}
<div class="openpa-line class-{$node.class_identifier} media {$node|access_style}">

    {if $node|has_attribute( 'image' )}
        <div class="media-image">
            <a href="{$openpa.content_link.full_link}">
                {attribute_view_gui attribute=$node|attribute( 'image' ) href=false() image_class=$image_class image_css_class="media-object" fluid=false()}
            </a>
        </div>
    {/if}
    <div class="media-body">
        <h3 class="media-heading">
            <a href="{$openpa.content_link.full_link}">{$node.name|wash()}</a>
        </h3>

        
          <ul class="media-details">
          {if $openpa.content_line.has_content}
            {foreach $openpa.content_line.attributes as $openpa_attribute}
              <li>
                {if $openpa_attribute.line.show_label}
                 <strong>{$openpa_attribute.label}:</strong>
                {/if}
                {attribute_view_gui attribute=$openpa_attribute.contentobject_attribute href=cond($openpa_attribute.line.show_link|not, 'no-link', '')}
              </li>
            {/foreach}
          {/if}
            {def $produttore_prodotti=fetch( 'content', 'reverse_related_objects', 
                          hash( 'object_id',$node.object.id, 
                                'sort_by',  array( 'name', true() ),
                                'ignore_visibility', false(),
                                'attribute_identifier', 'private_organization_nt/produttore_prodotti' ) )}
            {if $produttore_prodotti|count()}
            <li><strong>Produttori:</strong>
            {foreach $produttore_prodotti as $object}
                {node_view_gui content_node=$object.main_node view=text_linked}{delimiter},{/delimiter}
            {/foreach}            
            </li>
            {/if}
          </ul>
        

    </div>
</div>
