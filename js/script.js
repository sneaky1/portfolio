"use strict";

document.addEventListener("DOMContentLoaded", () => {
    const yearElement = document.getElementById("current-year");

    if (yearElement) {
        yearElement.textContent = new Date().getFullYear();
    }

    const dropdowns = document.querySelectorAll(".nav-dropdown");

    dropdowns.forEach((dropdown) => {
        const button = dropdown.querySelector(".nav-dropdown-toggle");

        if (!button) {
            return;
        }

        button.addEventListener("click", (event) => {
            event.stopPropagation();

            dropdowns.forEach((otherDropdown) => {
                if (otherDropdown !== dropdown) {
                    otherDropdown.classList.remove("open");

                    const otherButton = otherDropdown.querySelector(
                        ".nav-dropdown-toggle"
                    );

                    if (otherButton) {
                        otherButton.setAttribute("aria-expanded", "false");
                    }
                }
            });

            const isOpen = dropdown.classList.toggle("open");
            button.setAttribute("aria-expanded", String(isOpen));
        });
    });

    document.addEventListener("click", () => {
        dropdowns.forEach((dropdown) => {
            dropdown.classList.remove("open");

            const button = dropdown.querySelector(".nav-dropdown-toggle");

            if (button) {
                button.setAttribute("aria-expanded", "false");
            }
        });
    });

    document.addEventListener("keydown", (event) => {
        if (event.key === "Escape") {
            dropdowns.forEach((dropdown) => {
                dropdown.classList.remove("open");

                const button = dropdown.querySelector(
                    ".nav-dropdown-toggle"
                );

                if (button) {
                    button.setAttribute("aria-expanded", "false");
                }
            });
        }
    });

    const searchData = [
        {
            title: "Projects",
            type: "Page",
            url: "projects.html",
            keywords: "projects portfolio automation sql security"
        },
        {
            title: "Chromebook Repair Management System",
            type: "Case Study",
            url: "projects/chromebook-repair.html",
            keywords: "chromebook repair blazor asp.net sql inventory tickets"
        },
        {
            title: "Screenshot Gallery",
            type: "Gallery",
            url: "gallery.html",
            keywords: "screenshots images dashboard tickets inventory api"
        },
        {
            title: "PowerShell Administration Toolkit",
            type: "Toolkit",
            url: "powershell-toolkit/index.html",
            keywords: "powershell scripts automation administration"
        },
        {
            title: "PowerShell Toolkit Case Study",
            type: "Case Study",
            url: "projects/powershell-toolkit.html",
            keywords: "powershell toolkit case study automation"
        },
        {
            title: "Active Directory User Audit",
            type: "Script",
            url: "powershell-toolkit/view-Get-ActiveDirectoryUserAudit.html",
            keywords: "active directory audit users groups password last logon"
        },
        {
            title: "Remote User Disk Usage",
            type: "Script",
            url: "powershell-toolkit/view-Get-RemoteUserDiskUsage.html",
            keywords: "remote disk usage user profiles report"
        },
        {
            title: "Message Summary",
            type: "Script",
            url: "powershell-toolkit/view-Get-MessageSummary.html",
            keywords: "csv message summary errors frequency"
        },
        {
            title: "Rename Images from CSV",
            type: "Script",
            url: "powershell-toolkit/view-Rename-ImagesFromCsv.html",
            keywords: "rename images bulk csv files"
        },
        {
            title: "Active Directory Audit Documentation",
            type: "Documentation",
            url: "powershell-toolkit/view-doc-Get-ActiveDirectoryUserAudit.html",
            keywords: "active directory documentation audit"
        },
        {
            title: "Remote Disk Usage Documentation",
            type: "Documentation",
            url: "powershell-toolkit/view-doc-Get-RemoteUserDiskUsage.html",
            keywords: "disk usage documentation remote"
        },
        {
            title: "Message Summary Documentation",
            type: "Documentation",
            url: "powershell-toolkit/view-doc-Get-MessageSummary.html",
            keywords: "message summary documentation csv"
        },
        {
            title: "Rename Images Documentation",
            type: "Documentation",
            url: "powershell-toolkit/view-doc-Rename-ImagesFromCsv.html",
            keywords: "rename images documentation csv"
        },
        {
            title: "Active Directory Audit Sample",
            type: "Sample Result",
            url: "powershell-toolkit/view-sample-active-directory-user-audit.html",
            keywords: "active directory sample results users"
        },
        {
            title: "About Adam Thomas",
            type: "Page",
            url: "about.html",
            keywords: "about experience skills biography"
        },
        {
            title: "Contact",
            type: "Page",
            url: "contact.html",
            keywords: "contact email message"
        }
    ];

    const searchForms = document.querySelectorAll(".site-search");

    searchForms.forEach((searchForm) => {
        const rootPrefix = searchForm.dataset.root || "";
        const input = searchForm.querySelector("input");
        const resultsPanel = searchForm.querySelector(
            ".search-results-panel"
        );

        if (!input || !resultsPanel) {
            return;
        }

        const renderResults = () => {
            const query = input.value.trim().toLowerCase();

            if (query.length < 2) {
                resultsPanel.innerHTML = "";
                resultsPanel.classList.remove("open");
                return;
            }

            const matches = searchData
                .filter((item) => {
                    const searchableText = [
                        item.title,
                        item.type,
                        item.keywords
                    ]
                        .join(" ")
                        .toLowerCase();

                    return searchableText.includes(query);
                })
                .slice(0, 8);

            if (matches.length === 0) {
                resultsPanel.innerHTML =
                    '<p class="search-empty">No matching pages found.</p>';
                resultsPanel.classList.add("open");
                return;
            }

            resultsPanel.innerHTML = matches
                .map(
                    (item) => `
                        <a class="search-result-item" href="${rootPrefix}${item.url}">
                            <span class="search-result-title">
                                ${item.title}
                            </span>

                            <span class="search-result-type">
                                ${item.type}
                            </span>
                        </a>
                    `
                )
                .join("");

            resultsPanel.classList.add("open");
        };

        input.addEventListener("input", renderResults);

        input.addEventListener("keydown", (event) => {
            if (event.key === "Escape") {
                resultsPanel.classList.remove("open");
                input.blur();
            }
        });

        searchForm.addEventListener("submit", (event) => {
            event.preventDefault();

            const firstResult = resultsPanel.querySelector(
                ".search-result-item"
            );

            if (firstResult) {
                window.location.href = firstResult.href;
            }
        });

        document.addEventListener("click", (event) => {
            if (!searchForm.contains(event.target)) {
                resultsPanel.classList.remove("open");
            }
        });
    });
});

