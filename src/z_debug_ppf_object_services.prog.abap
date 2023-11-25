*&---------------------------------------------------------------------*
*& Report Z_DEBUG_PPF_OBJECT_SERVICES
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_debug_ppf_object_services.

DATA lo_trigger TYPE REF TO cl_trigger_ppf.

DATA lo_appl TYPE REF TO cl_book_ppf.

BREAK-POINT.

DATA(lo_ppf_manager) = cl_manager_ppf=>get_instance( ).



*     create trigger
TRY.
    DATA(lo_agent) = ca_trigger_ppf=>agent.

    lo_trigger ?=
ca_trigger_ppf=>agent->if_os_ca_persistency~get_persistent_by_oid( 'E3ED1F813DAC1EDEA2F7ADC3A1462150' ).

*    lo_agent->if_os_factory~refresh_persistent( lo_trigger ).

    lo_trigger ?=
 ca_trigger_ppf=>agent->if_os_ca_persistency~get_persistent_by_oid( 'E3ED1F813DAC1EDEA2F7ADC3A1462150' ).

    lo_trigger ?=
ca_trigger_ppf=>agent->if_os_ca_persistency~get_persistent_by_oid( 'E3ED1F813DAC1EDEA2F9154013C3A23E' ).


    IF 1 = 2.

      lo_agent->if_os_factory~refresh_persistent( lo_trigger ).

      lo_appl ?= lo_trigger->get_appl( ).
*CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden

      lo_appl->bi_persistent~refresh( ).

      lo_appl->if_os_state~invalidate( ).
*CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden


    ENDIF.


*
*    lo_trigger ?=
*      ca_trigger_ppf=>agent->if_os_ca_persistency~get_persistent_by_oid( 'E3ED1F813DAC1EDEA2F7ADC3A1462150' ).
*
*    lo_trigger ?=
*      ca_trigger_ppf=>agent->if_os_ca_persistency~get_persistent_by_oid( 'E3ED1F813DAC1EDEA2F7ADC3A1462150' ).

  CATCH cx_os_object_not_found
        cx_os_class_not_found.

ENDTRY.


*
*lo_trigger->set_is_changed( i_is_changed = 'X' ).
**CATCH cx_os_object_not_found. " Object Services: Objekt nicht gefunden

BREAK-POINT .

RETURN.


IF 1 = 2.

  CALL FUNCTION 'SPPF_PROCESS'
    EXPORTING
      ip_trigger_guid = 'E3ED1F813DAC1EDEA2F7ADC3A1462150'.


**lo_trigger->execute(
***  EXPORTING
***    ip_check_opt_rule       =                  " Optimierungsregel prüfen
***    ip_appl_already_locked  =                  " Anwendungsobjekt bereits gesperrt
**  RECEIVING
**    rp_rc                   =   data(l_rc)               " Returncode
**  EXCEPTIONS
**    empty_medium_reference  = 1                " Medienreferenz ist leer
**    empty_appl_reference    = 2                " Anwendungsreferenz ist leer
**    locked                  = 3                " Aktion ist gegen Verarbeitung gesperrt
**    document_is_locked      = 4                " Anwendungsdokument ist gesperrt
**    inactive                = 5                " Aktion ist nicht aktiv
**    startcondition_not_true = 6                " Startbedingung ist nicht erfüllt
**    others                  = 7
**).
**IF sy-subrc <> 0.
*** MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
***   WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
**ENDIF.

ENDIF.
