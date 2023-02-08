package com.axelor.apps.fleet.web;

import com.axelor.apps.fleet.db.FleetBatch;
import com.axelor.apps.fleet.db.repo.FleetBatchRepository;
import com.axelor.rpc.ActionRequest;
import com.axelor.rpc.ActionResponse;

public class FleetBatchController {

	public void fillVehicle(ActionRequest request, ActionResponse response) {
		runBatch(FleetBatchRepository.ACTION_FILL_VEHICLE, request, response);
	}
	
	protected void runBatch (Integer actionSelect, ActionRequest request, ActionResponse response) {
		FleetBatch fleetBatch = request.getContext().asType(FleetBatch.class);
		
		if ()
		
	}
	
}
