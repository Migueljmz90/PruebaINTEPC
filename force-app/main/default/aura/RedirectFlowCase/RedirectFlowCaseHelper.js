({
    getRecordIdCase: function(component, event, helpler) {
        var idCase = component.get("{!v.idCase}");
        var result = idCase;
        var hostname = window.location.hostname;
        var urlEvent = $A.get("e.force:navigateToURL");
        urlEvent.setParams({
            //"url": hostname + "/s/case/" + result + "/detail"
            "url": hostname + "/s/"
        });
        urlEvent.fire();
    }
})