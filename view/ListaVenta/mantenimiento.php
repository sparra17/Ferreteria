<!-- Default Modals -->
<div id="modaldetalle" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Detalle</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
            </div>

                <div class="modal-body">
                    <table id="detalle_data" class="table table-bordered dt-responsive nowrap table-striped align-middle" style="width:100%">
                        <thead>
                            <tr>
                                <th>Codigo</th>
                                <th>Producto</th>
                                <th>Categoria</th>
                                <th>Unidad</th>
                                <th>Precio</th>
                                <th>Fecha Ven.</th>
                                <th>Cantidad</th>
                                <th>Total</th>
                            </tr>
                        </thead>
                        <tbody>
                                                    
                        </tbody>
                    </table>

                    <table class="table table-borderless table-nowrap align-middle mb-0 ms-auto" style="width:250px">
                        <tbody>
                            <tr>
                                <td>Sub Total</td>
                                <td class="text-end" id="txtsubtotal">$0</td>
                            </tr>
                            <tr>
                                <td>IVA (16%)</td>
                                <td class="text-end" id="txtiva">0</td>
                            </tr>
                            <tr>
                                <td>Descuento <small class="text-muted"></small></td>
                                <td class="text-end" id="txtdescuento">0</td>
                            </tr>
                            <tr class="border-top border-top-dashed fs-15">
                                <th scope="row">Total</th>
                                <th class="text-end" id="txttotal">0</th>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-light" data-bs-dismiss="modal">Cerrar</button>
                </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->