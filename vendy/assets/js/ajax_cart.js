function ajaxHandler(e) {
  e.preventDefault();
  const post_url = $(this).attr("action");

  // get form action
  const form_data = $(this).serialize();

  // Encode form elements for submission
  $.post(post_url, form_data, function(response) {
    $.bootstrapGrowl(response.message, {
      offset: { from: "top", amount: 60 },
      width: 500,
      type: "success"
    });
    $(".cart-count").text(response.cart_count);
  });
}

const ajaxCart = {
  init: function() {
    $(function() {
      $(".cart-form").on("submit", ajaxHandler);
    });
  }
};

export default ajaxCart;
