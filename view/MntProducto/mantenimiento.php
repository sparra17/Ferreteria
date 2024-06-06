<!-- Default Modals -->
<div id="modalmantenimiento" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lbltitulo"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
            </div>
            <form action="post" id="mantenimiento_form">
                <div class="modal-body">
                    <input type="hidden" name="idProducto" id="idProducto"/>
                    
                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Codigo</label>
                                <input type="text" class="form-control" id="Codigo" name="Codigo" required/>
                            </div>
                        </div>
                    </div>
                    
                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Nombre Del Produto</label>
                                <input type="text" class="form-control" id="NombreProducto" name="NombreProducto" required/>
                            </div>
                        </div>
                    </div>

                    

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Proveedor</label>
                                <select type="text" class="form-control form-select" name="idProveedor" id="idProveedor" aria-label="Seleccionar">
                                    <option selected>Seleccionar</option>
                                </select>
                            
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Categoria</label>
                                <select type="text" class="form-control form-select" name="idCategoria" id="idCategoria" aria-label="Seleccionar">
                                    <option selected>Seleccionar</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Unidad</label>
                                <select type="text" class="form-control form-select" name="idUnidad" id="idUnidad" aria-label="Seleccionar">
                                    <option selected>Seleccionar</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Precio Compra</label>
                                <input type="text" class="form-control" id="PCompra" name="PCompra" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Precio Venta</label>
                                <input type="text" class="form-control" id="PVenta" name="PVenta" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Stock</label>
                                <input type="text" class="form-control" id="Stock" name="Stock" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Fecha De Vencimiento</label>
                                <input type="text" class="form-control" id="FechaVencimiento" name="FechaVencimiento"/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Descripcion</label>
                                <input type="text" class="form-control" id="Descripcion" name="Descripcion" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Imagen</label>
                                <input type="file" class="form-control" id="Imagen" name="Imagen"/>
                            </div>
                        </div>
                    </div>

                    </br>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div class="text-center">
                                <a id="btnremoverfoto" class="btn btn-danger btn-icon waves-effect waves-light btn-sm"><i class="ri-delete-bin-5-line"></i></a>
                                <span id="pre_imagen"></span>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-light" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" name="action" value="add" class="btn btn-primary ">Guardar</button>
                </div>
            </form>

        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->