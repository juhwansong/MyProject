(function () {
	"use strict";
	
	var $detailModal = $('#detail');
	
	$('.btn-adoption').on('click', function () {
		var $this = $(this);
		var $parent = $this.parents('.vm-adoptionPetList__petContent');
		var petId = $parent.find('[name="pet_id"]').val();
		
		$detailModal.find('[name="pet_id"]').val(petId);
		$detailModal.modal('show');
	});
}());