<div id="modalmantenimiento" class="modal fade" tabindex="-1" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="lbltitulo"></h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"> </button>
            </div>
            <form action="post" id="mantenimiento_form">
                <div class="modal-body">
                    <input type="hidden" name="idCliente" id="idCliente"/>
                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Nombre</label>
                                <input type="text" class="form-control" id="Nombre" name="Nombre" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Paterno</label>
                                <input type="text" class="form-control" id="Paterno" name="Paterno" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Materno</label>
                                <input type="text" class="form-control" id="Materno" name="Materno"/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                        <label for="valueInput" class="form-label">Sexo</label>
                            <select class="form-select" aria-label="Default select example" id="Sexo" name="Sexo" required>
                                <option selected>Sexo</option>
                                <option value="H">Hombre</option>
                                <option value="M">Mujer</option>
                                <option value="NU">No Identificado</option>
                            </select>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Direccion</label>
                                <input type="text" class="form-control" id="Direccion" name="Direccion" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Telefono</label>
                                <input type="text" class="form-control" id="Telefono" name="Telefono" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">Correo</label>
                                <input type="text" class="form-control" id="Correo" name="Correo" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">CURP</label>
                                <input type="text" class="form-control" id="CURP" name="CURP" required/>
                            </div>
                        </div>
                    </div>

                    <div class="row gy-2">
                        <div class="col-md-12">
                            <div>
                                <label for="valueInput" class="form-label">RFC</label>
                                <input type="text" class="form-control" id="RFC" name="RFC" required/>
                            </div>
                        </div>
                    </div>


                </div>
                <div class="modal-footer">
                    <button type="reset" class="btn btn-light" data-bs-dismiss="modal">Cerrar</button>
                    <button type="submit" name="action" value="add" class="btn btn-primary ">Guardar</button>
                </div>
            </form>
        </div>
    </div>
</div>