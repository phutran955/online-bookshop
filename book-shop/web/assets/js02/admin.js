
$(document).ready(function () {
    // Gắn sự kiện click vào các tab (menu bên trái)
    function bindTabClicks() {
        $('.action-link').off('click').on('click', function (e) {
            e.preventDefault();

            // Active UI tab
            $('.action-link').removeClass('active');
            $(this).addClass('active');

            const controller = $(this).data('controller') || 'MainController';
            const action = $(this).data('action');
            const params = {action: action};

            // Gắn thêm tham số nếu có
            if ($(this).data('id'))
                params.id = $(this).data('id');
            if ($(this).data('keyword'))
                params.keyword = $(this).data('keyword');
            if ($(this).data('page'))
                params.page = $(this).data('page');

            $.ajax({
                url: controller,
                method: 'GET',
                data: params,
                success: function (data) {
                    $('#rightContent').html(data);
                    bindFormSubmit();
                    bindTabClicks(); // gắn lại nếu nội dung mới có tab
                },
                error: function () {
                    $('#rightContent').html('<p style="color:red;">Không thể tải nội dung.</p>');
                }
            });
        });
    }

    // Gắn sự kiện submit cho form
    function bindFormSubmit() {
        $('#rightContent').find('form').off('submit').on('submit', function (e) {
            e.preventDefault();

            const $form = $(this);
            const controller = $form.data('controller') || 'MainController';
            const action = $form.find('input[name="action"]').val();
            const successAction = $form.data('success-action');

            $.ajax({
                url: controller + '?action=' + action,
                method: 'POST',
                data: $form.serialize(),
                success: function (data) {
                    const temp = $('<div>').html(data);
                    const successMessage = temp.find('.success-message').text().trim();
                    const errorMessage = temp.find('.error-message').text().trim();

                    if (successMessage && successAction) {
                        showMessage(successMessage, 'success');
                        // Reload lại nội dung danh sách
                        $.ajax({
                            url: controller,
                            method: 'GET',
                            data: {action: successAction},
                            success: function (html) {
                                $('#rightContent').html(html);
                                bindFormSubmit();
                                bindTabClicks();
                            }
                        });
                    } else {
                        if (errorMessage) {
                            showMessage(errorMessage, 'error');
                        }
                        $('#rightContent').html(data);
                        bindFormSubmit();
                        bindTabClicks();
                    }
                },
                error: function () {
                    showMessage('Lỗi khi gửi biểu mẫu.', 'error');
                }
            });
        });
    }

    function bindInlineActionForms() {
        $('.ajax-action-form').off('submit').on('submit', function (e) {
            e.preventDefault();
            const $form = $(this);
            const controller = $form.data('controller') || 'MainController';
            const formData = $form.serialize();

            $.ajax({
                url: controller,
                method: 'POST',
                data: formData,
                success: function (data) {
                    $('#rightContent').html(data);
                    bindFormSubmit();
                    bindTabClicks();
                    bindInlineActionForms();
                },
                error: function () {
                    $('#rightContent').html('<p style="color:red;">Lỗi khi xử lý yêu cầu.</p>');
                }
            });
        });
    }

    // Hàm hiển thị thông báo
    function showMessage(message, type) {
        const $msg = $('#formMessage');
        $msg.removeClass().addClass(type === 'success' ? 'message-success' : 'message-error')
                .text(message)
                .fadeIn();

        // Tự động ẩn sau 4s
        setTimeout(() => $msg.fadeOut(), 4000);
    }

    // Gắn sự kiện lần đầu
    bindTabClicks();
    bindFormSubmit();
    bindInlineActionForms(); // 👈 thêm dòng này

    // Tự động click tab mặc định
    $('.action-link.default').trigger('click');
});

