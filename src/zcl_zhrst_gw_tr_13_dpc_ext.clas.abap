class ZCL_ZHRST_GW_TR_13_DPC_EXT definition
  public
  inheriting from ZCL_ZHRST_GW_TR_13_DPC
  create public .

public section.
protected section.

  methods TESTESET_CREATE_ENTITY
    redefinition .
  methods TESTESET_DELETE_ENTITY
    redefinition .
  methods TESTESET_GET_ENTITYSET
    redefinition .
  methods ORGUNITSET_GET_ENTITYSET
    redefinition .
private section.
ENDCLASS.



CLASS ZCL_ZHRST_GW_TR_13_DPC_EXT IMPLEMENTATION.


  METHOD orgunitset_get_entityset.

    TRY.
        DATA(r_pernr) = it_filter_select_options[ property = 'pernr' ]-select_options.
    ENDTRY.

    IF r_pernr IS INITIAL.

      SELECT * FROM hrp1000 INTO @DATA(lt_retorno).

        APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<fs_entity>).
        <fs_entity>-pernr = lt_retorno-objid.

      ENDSELECT.

    ELSE.

    ENDIF.

  ENDMETHOD.


  METHOD testeset_create_entity.

    io_data_provider->read_entry_data( IMPORTING es_data = er_entity ).

  ENDMETHOD.


  METHOD testeset_delete_entity.

    DATA: vl_pernr TYPE pernr_d.
    DATA: cx_error TYPE REF TO cx_root.
    DATA : lo_msg TYPE REF TO /iwbep/if_message_container.

    CALL METHOD me->/iwbep/if_mgw_conv_srv_runtime~get_message_container
      RECEIVING
        ro_message_container = lo_msg.
    TRY.
        vl_pernr = it_key_tab[ name = 'pernr' ]-value.
      CATCH cx_root INTO cx_error.
        CALL METHOD lo_msg->add_message
          EXPORTING
            iv_msg_type   = /iwbep/cl_cos_logger=>error
            iv_msg_id     = 'ZHRST_GW_TR_00'
            iv_msg_number = '000'.

        RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
          EXPORTING
            message_container = lo_msg.
    ENDTRY.

    IF vl_pernr < '1'.
      CALL METHOD lo_msg->add_message
        EXPORTING
          iv_msg_type   = /iwbep/cl_cos_logger=>error
          iv_msg_id     = 'ZHRST_GW_TR_00'
          iv_msg_number = '000'.

      RAISE EXCEPTION TYPE /iwbep/cx_mgw_busi_exception
        EXPORTING
          message_container = lo_msg.
    ENDIF.

  ENDMETHOD.


  METHOD testeset_get_entityset.

    TRY.
      DATA(r_text) = it_filter_select_options[ property = 'text' ]-select_options.
    ENDTRY.

    APPEND INITIAL LINE TO et_entityset ASSIGNING FIELD-SYMBOL(<fs_entity>).
    <fs_entity>-pernr = '1'.
    <fs_entity>-text = 'Hello World'.

  endmethod.
ENDCLASS.
