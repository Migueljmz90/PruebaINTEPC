({
    handleOnLoad : function(component, event){
        var action = component.get("c.getCaseRecordTypeID");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                component.set("v.recordTypeID", response.getReturnValue());
            }
            else {
                component.find('notifLib').showToast({
                    "variant": "error",
                    "title": "error",
                    "message": "Error trying to create case"
                });
            }
        });
        $A.enqueueAction(action);
    },
    handleSubmit : function(cmp, event, helper) {
        event.preventDefault();       // stop the form from submitting
        const fields = event.getParam('fields');
        if(fields.ContactId === null || fields.ContactId === undefined) {
            var action = cmp.get("c.getContactId");
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    this.fields.ContactId = response.getReturnValue();
                }
                else {
                    this.component.find('notifLib').showToast({
                        "variant": "error",
                        "title": "error",
                        "message": "Error trying to create case"
                    });
                }
            });
            $A.enqueueAction(action);
        }
        cmp.find('myRecordForm').submit(fields);    
    },

    handleSuccess : function(component, event, helper) {
        component.find('notifLib').showToast({
            "variant": "success",
            "title": "Caso Creado", 
            "message": "ID de Caso: " + event.getParam("fields").CaseNumber.value
        }); 
        var workspaceAPI = component.find("workspace");
        workspaceAPI.closeTab(workspaceAPI.getEnclosingTabId())
    },
    handleCancel : function(component){
        $A.get("e.force:closeQuickAction").fire()
        var workspaceAPI = component.find("workspace");
        workspaceAPI.closeTab(workspaceAPI.getEnclosingTabId())
    }
})