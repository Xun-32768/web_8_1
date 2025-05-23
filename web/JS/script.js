function showSubMenu(parentLi) {
    var subMenu = document.getElementById('subMenu');
    if (subMenu.style.display === 'none') {
        subMenu.style.display = 'block';
    } else {
        subMenu.style.display = 'none';
    }
}