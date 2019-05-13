<?php

class NutriretrentoOperators
{
    function operatorList()
    {
        return array(
            'nutriretrento_product_tree'
        );
    }

    function namedParameterPerOperator()
    {
        return true;
    }

    function namedParameterList()
    {
        return array(
            'nutriretrento_product_tree' => array(
                'object' => array('type' => 'object', 'required' => true)
            )
        );
    }

    function modify(
        $tpl,
        $operatorName,
        $operatorParameters,
        $rootNamespace,
        $currentNamespace,
        &$operatorValue,
        $namedParameters
    ) {
        try {
            switch ($operatorName) {
                case 'nutriretrento_product_tree':
                    {                        
                        $object = $namedParameters['object'];
                        $operatorValue = $this->getProductTree($object);
                    }
                    break;
            }
        } catch (Exception $e) {
            eZDebug::writeError($e->getMessage(), __METHOD__ . ':' . $operatorName);
        }
    }

    private function getProductTree($object)
    {        
        $tree = array();
        if ($object instanceof eZContentObject){
            $dataMap = $object->attribute('data_map');
            if (isset($dataMap['produttore_prodotti']) && $dataMap['produttore_prodotti']->hasContent()){
                $idList = explode('-', $dataMap['produttore_prodotti']->toString());
                foreach ($idList as $id) {
                    $product = eZContentObject::fetch($id);
                    if ($product instanceof eZContentObject){
                        $productDataMap = $product->attribute('data_map');
                        if (isset($productDataMap['categoria_prodotto']) && $productDataMap['categoria_prodotto']->hasContent()){
                            $keywords = $productDataMap['categoria_prodotto']->attribute('content')->attribute('keywords');
                            foreach ($keywords as $keyword) {
                                $tree[$keyword][$product->attribute('name')] = $product;
                            }
                        }
                    }
                }
            }
        }
        return $tree;
    }
}
